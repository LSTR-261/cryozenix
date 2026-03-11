{
  pkgs,
  config,
  ...
}: {
  imports =
    [
      ./audiobookshelf.nix
      ./copyparty.nix
      ./forgejo.nix
      ./glance.nix
      ./home-assistant.nix
      ./immich.nix
      # ./comfyui.nix
      # ./jupyter.nix
      # ./minecraft.nix
      # ./navidrome.nix
      ./torbox.nix
      ./vaultwarden.nix
    ]
    ++ [
      ./arr/nzbhydra2.nix
    ];

  users.groups.media = {};

  virtualisation.containers.enable = true;
  virtualisation.oci-containers.backend = "podman";
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
