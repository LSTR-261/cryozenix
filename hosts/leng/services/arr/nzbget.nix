{
  services.nzbget = {
    enable = true;
    settings = {MainDir = "/storage/usenet";};
  };
  users.users.nzbget.extraGroups = ["media"];
  networking.firewall.allowedTCPPorts = [6789];

  services.caddy.virtualHosts."nzbget.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:6789
  '';
}
