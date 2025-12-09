{
  email,
  username,
  outputs,
  ...
}: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "${username}";
      user.email = "${email}";
    };
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      allowBroken = true;
    };
  };

  home.stateVersion = "25.11";
}
