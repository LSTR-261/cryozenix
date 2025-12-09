{
  services.nzbhydra2 = {
    enable = true;
    openFirewall = true;
  };

  services.caddy.virtualHosts."hydra.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:5076
  '';
}
