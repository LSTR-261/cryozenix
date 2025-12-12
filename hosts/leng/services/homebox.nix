{
  services.homebox = {
    enable = true;
    settings = {
      HBOX_WEB_HOST = "0.0.0.0";
      HBOX_OPTIONS_ALLOW_REGISTRATION = "true";
    };
  };
  networking.firewall.allowedTCPPorts = [7745];
  services.caddy.virtualHosts."hbox.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:7745
  '';
}
