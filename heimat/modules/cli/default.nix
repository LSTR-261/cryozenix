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
    yazi.enable = true;
  };
  home.packages = with pkgs; [
    xh
    unzip
  ];
  modules = {
    fish = true;
    helix = true;
  };
}
