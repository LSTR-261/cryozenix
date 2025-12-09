{
  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true;
    # package = pkgs.minecraft-server_1_20_1;
  };
  services.caddy.virtualHosts."mc.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:25565
  '';
}
