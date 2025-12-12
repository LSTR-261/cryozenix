{
  pkgs,
  config,
  ...
}: {
  imports =
    [
      # ./authelia.nix
      ./audiobookshelf.nix
      ./copyparty.nix
      ./forgejo.nix
      ./glance.nix
      # ./grafana.nix
      ./home-assistant.nix
      ./homebox.nix
      # ./homarr.nix
      ./immich.nix
      ./jellyfin.nix
      # ./minecraft.nix
      ./navidrome.nix
      ./paperless.nix
      ./trilium.nix
      # ./ollama.nix
      # ./matrix.nix
      ./torbox.nix
      ./vaultwarden.nix
      # ./n8n.nix
    ]
    ++ [
      ./arr/prowlarr.nix
      ./arr/nzbhydra2.nix
      # ./arr/nzbget.nix
      # ./arr/lidarr.nix
      # ./arr/sonarr.nix
      # ./arr/radarr.nix
    ];

  users.groups.media = {};

  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
