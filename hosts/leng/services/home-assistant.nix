{
  services.home-assistant = {
    enable = true;
    openFirewall = true;
    extraComponents = [
      "analytics"
      "default_config"
      "esphome"
      "my"
      "shopping_list"
      "wled"
      "mqtt"
    ];
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
      default_config = {};
    };
  };
  services.caddy.virtualHosts."home.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:8123
  '';
}
