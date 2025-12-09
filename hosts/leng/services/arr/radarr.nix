{
  services.radarr = {
    enable = true;
    openFirewall = true;
  };
  systemd.tmpfiles.rules = ["d /storage/movies 0775 radarr media -"];

  services.caddy.virtualHosts."radarr.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:7878
  '';
}
