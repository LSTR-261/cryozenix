{pkgs, ...}: {
  services.glance = {
    enable = true;
    openFirewall = true;
    settings.server.host = "0.0.0.0";
    settings.server.port = 5678;
    settings.pages = [
      {
        name = "Heimat";
        columns = [
          {
            size = "small";
            widgets = [
              {
                type = "server-stats";
                servers = [
                  {
                    type = "local";
                    name = "LENG";
                    hide-swap = true;
                    hide-mountpoints-by-default = true;
                    mountpoints = {
                      "/storage" = {hide = false;};
                      "/" = {hide = false;};
                    };
                  }
                ];
              }
              {
                type = "calendar";
                first-day-of-week = "monday";
              }
              {
                type = "hacker-news";
                limit = 25;
              }
            ];
          }
          {
            size = "full";
            widgets = [
              {
                type = "group";
                widgets = [
                  {
                    type = "search";
                    search-engine = "duckduckgo";
                    bangs = [
                      {
                        title = "NixOS";
                        shortcut = "#";
                        url = "https://mynixos.com/search?q={QUERY}";
                      }
                    ];
                  }
                ];
              }
              {
                type = "monitor";
                title = "Services";
                sites = [
                  {
                    title = "Jellyfin";
                    url = "https://jelly.lstr-261.eu/";
                    icon = "di:jellyfin";
                  }
                  {
                    title = "ForgeJo";
                    url = "https://git.lstr-261.eu/";
                    icon = "di:forgejo";
                  }
                  {
                    title = "AudioBookShelf";
                    url = "https://bookery.lstr-261.eu/";
                    icon = "di:audiobookshelf";
                  }
                  {
                    title = "Immich";
                    url = "https://photos.lstr-261.eu/";
                    icon = "di:immich";
                  }
                  {
                    title = "Jupyter";
                    url = "https://python.lstr-261.eu";
                    icon = "di:jupyter";
                  }
                  {
                    title = "Trilium";
                    url = "https://notes.lstr-261.eu";
                    icon = "di:trilium";
                  }
                  {
                    title = "Paperless";
                    url = "https://docs.lstr-261.eu/";
                    icon = "di:paperless";
                  }
                  {
                    title = "Copyparty";
                    url = "https://files.lstr-261.eu";
                    icon = "di:copyparty";
                  }
                  {
                    title = "Navidrome";
                    url = "https://music.lstr-261.eu";
                    icon = "di:navidrome";
                  }
                  {
                    title = "Grafana";
                    url = "https://grafana.lstr-261.eu";
                    icon = "di:grafana";
                  }
                  {
                    title = "Homeassistant";
                    url = "https://home.lstr-261.eu";
                    icon = "di:home-assistant";
                  }
                  {
                    title = "Vaultwarden";
                    url = "https://vault.lstr-261.eu";
                    icon = "di:vaultwarden";
                  }
                ];
              }
              {
                type = "split-column";
                widgets = [
                  {
                    type = "reddit";
                    subreddit = "signalis";
                    show-thumbnails = true;
                  }
                  {
                    type = "reddit";
                    subreddit = "analog";
                    show-thumbnails = true;
                  }
                  {
                    type = "reddit";
                    subreddit = "nixos";
                    show-thumbnails = false;
                  }
                  {
                    type = "reddit";
                    subreddit = "niri";
                    show-thumbnails = false;
                  }
                ];
              }
            ];
          }
          {
            size = "small";
            widgets = [
              {
                type = "weather";
                location = "Achim, Germany";
                hour-format = "24h";
                show-area-name = true;
              }
              {
                type = "markets";
                markets = [
                  {
                    symbol = "TKMS.DE";
                    name = "TKMS";
                  }
                  {
                    symbol = "MEUD.PA";
                    name = "Stoxx Europe 600";
                  }
                  {
                    symbol = "HEMA.MI";
                    name = "MSCI Emerging Markets";
                  }
                  {
                    symbol = "XDWD.L";
                    name = "MSCI World";
                  }
                ];
              }
              {
                type = "monitor";
                title = "*arr";
                sites = [
                  {
                    title = "NZBHydra2";
                    url = "https://hydra.lstr-261.eu/";
                    icon = "di:nzbhydra";
                  }
                  {
                    title = "Prowlarr";
                    url = "https://prowlarr.lstr-261.eu/";
                    icon = "di:prowlarr";
                  }
                  {
                    title = "Radarr";
                    url = "https://radarr.lstr-261.eu/";
                    icon = "di:radarr";
                  }
                  {
                    title = "Sonarr";
                    url = "https://sonarr.lstr-261.eu/";
                    icon = "di:sonarr";
                  }
                  {
                    title = "Lidarr";
                    url = "https://lidarr.lstr-261.eu/";
                    icon = "di:lidarr";
                  }
                  {
                    title = "Readarr";
                    url = "https://readarr.lstr-261.eu/";
                    icon = "di:readarr";
                  }
                ];
              }
            ];
          }
        ];
      }
    ];
  };
  environment.systemPackages = [pkgs.glance];
  services.caddy.virtualHosts."lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:5678
  '';
}
