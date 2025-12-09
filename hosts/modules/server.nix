{
  config,
  pkgs,
  hostname,
  ...
}: {
  services.caddy.enable = true;
  services.caddy.email = "philipp.hepp7@gmail.com";
  services.caddy.extraConfig = ''
    *.lstr-261.eu {
      tls /var/lib/acme/lstr-261.eu/cert.pem /var/lib/acme/lstr-261.eu/key.pem {
        protocols tls1.3
      }
    }
  '';
  age.secrets.porkbunApiKey.file = ../leng/secrets/porkbunApiKey.age;
  security.acme = {
    acceptTerms = true;
    defaults.email = "lstr-261@proton.me";
    defaults.server = "https://acme-v02.api.letsencrypt.org/directory";
    certs."lstr-261.eu" = {
      group = config.services.caddy.group;
      domain = "lstr-261.eu";
      extraDomainNames = ["*.lstr-261.eu" "*.${builtins.substring 0 1 hostname}.lstr-261.eu"];
      dnsProvider = "porkbun";
      dnsPropagationCheck = true;
      dnsResolver = "1.1.1.1:53";
      environmentFile = config.age.secrets.porkbunApiKey.path;
    };
  };
  networking.firewall.allowedTCPPorts = [80 443];
  networking.firewall.allowedUDPPorts = [9];
  networking.interfaces.enp4s0.wakeOnLan.enable = true;
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
