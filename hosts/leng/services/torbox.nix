{
  pkgs,
  config,
  ...
}: {
  virtualisation.oci-containers.containers.torbox-media-center = {
    image = "ghcr.io/torbox-app/torbox-media-center:main";
    autoStart = true; # Equivalent to 'restart: always'

    # Environment Variables
    environment = {
      # WARNING: Placing secrets here puts them in the world-readable Nix store.
      # See the "Handling Secrets" section below for a safer method.
      TORBOX_API_KEY = "33707a93-dc0a-47b8-9918-1b75a692c9f5";
      MOUNT_METHOD = "strm";
      MOUNT_PATH = "/torbox";
    };

    # Volumes
    # NixOS requires absolute paths. Replace 'yourusername' with your actual user.
    volumes = [
      "/storage/torbox:/torbox"
    ];

    # Equivalence for 'tty: true' and 'stdin_open: true'
    # Also includes FUSE flags which are often required for mounting functionality
    extraOptions = [
      "--tty" # -t
      "--interactive" # -i
      "--device=/dev/fuse" # Required if the container mounts filesystems
      "--cap-add=SYS_ADMIN" # Often required for mounting operations
      "--security-opt=label=disable" # SELinux permission fix for FUSE (optional but recommended)
    ];
  };
  # 2. Install rclone
  environment.systemPackages = [pkgs.rclone];

  # 3. Create the mount directory with correct permissions *before* mounting
  systemd.tmpfiles.rules = [
    "d /storage/media 0755 root media -"
  ];

  age.secrets.torboxCredentials.file = ../secrets/torboxCredentials.age;

  # 4. Systemd Mount Service
  systemd.services.torbox-mount = {
    description = "TorBox WebDAV Mount";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "notify";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount torbox: /storage/media/ \
          --config=${config.age.secrets.torboxCredentials.path} \
          --allow-other \
          --uid=0 \
          --gid=982 \
          --dir-perms=0755 \
          --file-perms=0755 \
          --umask=0022 \
          --vfs-cache-mode=full \
          --vfs-cache-max-size=10G \
          --no-modtime \
          --no-checksum
      '';
      ExecStop = "/run/wrappers/bin/fusermount -u /storage/media";
      Restart = "always";
      RestartSec = "10s";
    };
  };
}
