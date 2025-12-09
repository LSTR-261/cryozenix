{
  services.navidrome = {
    enable = true;
    group = "media";
    openFirewall = true;
    settings.Address = "0.0.0.0";
    settings.MusicFolder = "/storage/music";
  };

  services.caddy.virtualHosts."music.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:4533
  '';
}
