{pkgs, ...}: {
  programs = {
    fzf.enable = true;
    lazygit.enable = true;
    carapace = {
      enable = true;
      enableFishIntegration = true;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    television = {
      enable = true;
      enableFishIntegration = true;
    };
    bat.enable = true;
    yazi.enable = true;
  };
  home.packages = with pkgs; [
    xh
    unzip
    fd
  ];
  modules = {
    fish = true;
    helix = true;
  };
}
