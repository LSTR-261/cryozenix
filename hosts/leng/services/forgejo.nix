{pkgs, ...}: {
  services.forgejo = {
    enable = true;
    package = pkgs.forgejo;
    database.type = "postgres";
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "git.lstr-261.eu";
        ROOT_URL = "https://git.lstr-261.eu";
        HTTP_PORT = 3000;
      };
      service.DISABLE_REGISTRATION = true;
    };
  };

  services.caddy.virtualHosts."git.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:3000
  '';

  networking.firewall.allowedTCPPorts = [3000];
}
