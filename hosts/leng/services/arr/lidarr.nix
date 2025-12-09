{
  services.lidarr = {
    enable = true;
    openFirewall = true;
  };
  users.users.lidarr.extraGroups = ["media"];

  services.caddy.virtualHosts."lidarr.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:8686
  '';
}
