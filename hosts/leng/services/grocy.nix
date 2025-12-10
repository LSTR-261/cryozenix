{pkgs, ...}: {
  services.grocy = {
    enable = true;
    hostName = "grocy.lstr-261.eu";
    settings = {
      culture = "de";
      currency = "EUR";
      calendar.firstDayOfWeek = 1;
    };
    # nginx.enableSSL = false;
  };

  # services.caddy.virtualHosts."grocy.lstr-261.eu".extraConfig = ''
  # reverse_proxy leng.fritz.box:3000
  # '';
}
