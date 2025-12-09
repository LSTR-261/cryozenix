{
  services.home-assistant = {
    enable = true;
    openFirewall = true;
    config = {
      homeassistant = {
        latitude = 53.00470;
        longitude = 9.07917;
        name = "Heimat";
        temperature_unit = "C";
        unit_system = "metric";
      };
      http = {
        # cors_allowed_origins = "https://home.lstr-261.eu";
        use_x_forwarded_for = true;
        trusted_proxies = "10.200.4.124";
      };
    };
  };
  services.caddy.virtualHosts."home.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:8123
  '';
}
