{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./grafana.nix
    ./jupyter.nix
    ./minecraft.nix
    ./ollama.nix
  ];

  users.groups.media = {};
}
