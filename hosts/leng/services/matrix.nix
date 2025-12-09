{
  services.matrix-tuwunel = {
    enable = true;
    settings.global = {
      server_name = "lstr-261.eu";
      address = ["0.0.0.0"];
      allow_registration = true;
      registration_token = "mtrx-2wSx6zHn1qAy";
    };
  };
  networking.firewall.allowedTCPPorts = [6167];
  services.caddy.virtualHosts."matrix.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:6167
  '';
}
