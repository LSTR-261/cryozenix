{
  services.audiobookshelf = {
    enable = true;
    openFirewall = true;
    host = "0.0.0.0";
    port = 8090;
  };

  services.caddy.virtualHosts."bookery.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:8090
  '';
}
