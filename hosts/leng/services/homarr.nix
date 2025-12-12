{
  virtualisation.oci-containers.containers.homarr = {
    image = "ghcr.io/homarr-labs/homarr:latest";
    autoStart = true; # Equivalent to restart: unless-stopped

    ports = [
      "7575:7575"
    ];

    environment = {
      # WARNING: Putting secrets directly in nix files makes them world-readable
      # in the /nix/store. For production, consider using sops-nix or agenx.
      SECRET_ENCRYPTION_KEY = "495d7db65feffbd8aacb4cb5efd6bc07c930c41b1e938d5609a2eef7e6f48476";
    };

    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/var/lib/homarr/appdata:/appdata"
    ];
  };
  virtualisation.podman.dockerSocket.enable = true;
  networking.firewall.allowedTCPPorts = [7575];
}
