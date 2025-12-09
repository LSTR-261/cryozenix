{
  services.trilium-server.enable = true;
  services.trilium-server.dataDir = "/storage/trilium";
  services.trilium-server.host = "0.0.0.0";
  services.trilium-server.port = 12783;
  networking.firewall.allowedTCPPorts = [12783];

  services.caddy.virtualHosts."notes.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:12783
  '';
}
