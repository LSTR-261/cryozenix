{
  services.pyload = {
    enable = true;
    listenAddress = "0.0.0.0";
    port = 9876;
    downloadDirectory = "/storage/downloads";
    group = "media";
  };
  networking.firewall.allowedTCPPorts = [9876];
  services.caddy.virtualHosts."pyload.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:9876
  '';
}
