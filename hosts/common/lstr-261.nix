{pkgs, ...}: {
  users.users.lstr-261 = {
    initialPassword = "277353";
    isNormalUser = true;
    description = "LSTR-261";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "storage"
      "input"
      "media"
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILaJV1hJoTwKtjSbcMJ600EQVY6pE1ZFoX0wuMvbqG0O u0_a417@localhost"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvCzOHE06VyOQWJAfZ2iYAKLzOWAueW2D+oEyPcd+dF nix-on-droid@localhost"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJVHN4mvO7DmhMpTxm+RaLKmmtewiN1d54f5j3h4H2FX lstr-261@penrose"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN97n4CUueRg49CjV4zskJkJ9H8TJzN16vNyfFlg+EP0 lstr-261@vineta"
    ];
  };
  programs.fish.enable = true;
}
