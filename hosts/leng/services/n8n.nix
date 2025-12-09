{
  services.n8n = {
    enable = true;
    openFirewall = true;
    settings = {
      N8N_DIAGNOSTICS_ENABLED = false;
      N8N_VERSION_NOTIFICATIONS_ENABLED = false;
      N8N_TEMPLATES_ENABLED = false;
    };
  };

  services.caddy.virtualHosts."n8n.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:5678
  '';
}
