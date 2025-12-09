{
  services.readarr = {
    enable = true;
    openFirewall = true;
  };

  users.users.readarr.extraGroups = ["media"];

  services.caddy.virtualHosts."readarr.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:8787
  '';
}
