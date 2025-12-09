{
  pkgs,
  outputs,
  username,
  hostname,
  ...
}: {
  imports = [
    ./${username}.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
    ];
    config.allowUnfree = true;
  };
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" username];
      substituters = ["https://nix-community.cachix.org"];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.limine = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };
  security = {
    polkit.enable = true;
    sudo.execWheelOnly = true;
  };
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  services.xserver.xkb.layout = "eu";
  programs = {
    dconf.enable = true;
    nh.enable = true;
  };
  home-manager.backupFileExtension = "backup";
  system.stateVersion = "25.11";
}
