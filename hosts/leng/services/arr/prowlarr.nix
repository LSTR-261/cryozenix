{
  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.caddy.virtualHosts."prowlarr.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:9696
  '';
}
