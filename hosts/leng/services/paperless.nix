{
  services.paperless = {
    enable = true;
    mediaDir = "/storage/documents";
    address = "0.0.0.0";
    passwordFile = "/etc/paperless-admin-pass";
    settings = {
      PAPERLESS_OCR_LANGUAGE = "deu+eng";
      PAPERLESS_URL = "https://docs.lstr-261.eu";
    };
  };
  environment.etc."paperless-admin-pass".text = "admin";
  users.users.paperless.extraGroups = ["media"];
  networking.firewall.allowedTCPPorts = [28981];

  services.caddy.virtualHosts."docs.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:28981
  '';
}
