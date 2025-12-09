{config, ...}: {
  age.secrets = let
    authelia = {
      mode = "440";
      owner = config.services.authelia.instances.main.user;
      group = config.services.authelia.instances.main.group;
    };
  in {
    jwtSecret = {
      inherit (authelia) mode owner group;
      file = ../secrets/authelia/jwtSecret.age;
    };

    storageEncryptionKey = {
      inherit (authelia) mode owner group;
      file = ../secrets/authelia/storageEncryptionKey.age;
    };

    sessionSecret = {
      inherit (authelia) mode owner group;
      file = ../secrets/authelia/sessionSecret.age;
    };

    autheliaJwksKey = {
      inherit (authelia) mode owner group;
      file = ../secrets/authelia/autheliaJwksKey.age;
    };

    autheliaLldapPassword = {
      inherit (authelia) mode owner group;
      file = ../secrets/authelia/autheliaLldapPassword.age;
    };
  };
  services.redis.servers.authelia-main = {
    enable = true;
    user = "authelia-main";
    port = 0;
    unixSocket = "/run/redis-authelia-main/redis.sock";
    unixSocketPerm = 600;
  };
  services.lldap = {
    enable = true;
    settings = {
      ldap_base_dn = "dc=lstr-261,dc=eu";
      ldap_user_pass = "blablabla";
    };
    silenceForceUserPassResetWarning = true;
  };
  services.authelia.instances.main = let
    domain = "lstr-261.eu";
  in {
    enable = true;
    secrets = {
      jwtSecretFile = config.age.secrets.jwtSecret.path;
      storageEncryptionKeyFile = config.age.secrets.storageEncryptionKey.path;
      sessionSecretFile = config.age.secrets.sessionSecret.path;
      oidcIssuerPrivateKeyFile = config.age.secrets.autheliaJwksKey.path;
    };
    environmentVariables = {
      "AUTHELIA_AUTHENTICATION_BACKEND_LDAP_PASSWORD_FILE" = config.age.secrets.autheliaLldapPassword.path;
    };
    settings = {
      theme = "dark";
      access_control = {
        default_policy = "deny";
        rules = [
          {
            domain = ["auth.${domain}"];
            policy = "bypass";
          }
          {
            domain = ["*.${domain}"];
            policy = "one_factor";
          }
        ];
      };
      notifier = {
        disable_startup_check = false;
        filesystem = {
          filename = "/var/lib/authelia-main/notification.txt";
        };
      };
      session = {
        name = "authelia_session";
        expiration = "12h";
        inactivity = "45m";
        remember_me = "1M";
        redis.host = "/run/redis-authelia-main/redis.sock";
        cookies = [
          {
            domain = "${domain}";
            authelia_url = "https://auth.${domain}";
          }
        ];
      };
      storage.local.path = "/var/lib/authelia-main/db.sqlite3";
      regulation = {
        max_retries = 3;
        find_time = "5m";
        ban_time = "15m";
      };
      authentication_backend = {
        password_reset.disable = true;
        password_change.disable = true;
        refresh_interval = "1m";
        ldap = {
          address = "ldap://leng.fritz.box:3890";
          implementation = "lldap";
          timeout = "5s";
          base_dn = "dc=lstr-261,dc=eu";
          additional_users_dn = "ou=people";
          user = "uid=authelia,ou=people,dc=lstr-261,dc=eu";
        };
      };
      totp = {
        disable = false;
        algorithm = "sha1";
        digits = 6;
        period = 30;
      };
      identity_providers = {
        oidc = {
          lifespans = {
            access_token = "1h";
            authorize_code = "1m";
            id_token = "1h";
            refresh_token = "90m";
          };
          enable_client_debug_messages = true;
          require_pushed_authorization_requests = false;
          cors = {
            endpoints = [
              "authorization"
              "token"
              "revocation"
              "introspection"
            ];
            allowed_origins = ["https://*.${domain}"];
          };
          clients = [
            {
              client_id = "proxmox";
              client_name = "Proxmox";
              client_secret = "$argon2id$v=19$m=65536,t=3,p=4$FGfPJgtAdjDEe0wf8cFgLA$3wanv1DOfrRt5a1476gYmQkQtKorJLX5qRStYrXjEUQ";
              public = false;
              require_pkce = true;
              pkce_challenge_method = "S256";
              authorization_policy = "two_factor";
              redirect_uris = ["https://proxmox.lastprism.${domain}"];
              scopes = ["openid" "profile" "email" "groups"];
              response_types = ["code"];
              grant_types = ["authorization_code"];
              access_token_signed_response_alg = "none";
              userinfo_signed_response_alg = "none";
              token_endpoint_auth_method = "client_secret_basic";
            }
          ];
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [9091 17170 3890];
  services.caddy.virtualHosts."auth.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:9091
  '';
  services.caddy.virtualHosts."lldap.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:17170
  '';
}
