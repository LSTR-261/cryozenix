{pkgs, ...}:
{
  services.grocy = {
    enable = true;
    settings = {
      culture = "de";
      currency = "EUR";
    };
  };

  services.caddy.virtualHosts."grocy.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:3000
  '';
}
