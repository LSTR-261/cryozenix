{
  services.immich = {
    enable = true;
    openFirewall = true;
    host = "0.0.0.0";
    environment = {
      # UPLOAD_LOCATION = "/storage/immich/files";
      # THUMB_LOCATION = "/storage/immich/thumbs";
      # ENCODED_VIDEO_LOCATION = "/storage/immich/encoded-video";
      # PROFILE_LOCATION = "/custom/path/immich/profile";
      # BACKUP_LOCATION = "/custom/path/immich/backups";
    };
    mediaLocation = "/storage/immich";
  };
  users.users.immich.extraGroups = ["media"];

  services.caddy.virtualHosts."photos.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:2283
  '';
}
