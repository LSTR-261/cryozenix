{
  services.jellyfin = {
    enable = true;
    group = "media";
    openFirewall = true;
  };

  # users.users.jellyfin.extraGroups = ["media"];
  services.caddy.virtualHosts."jelly.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:8096
  '';
}
