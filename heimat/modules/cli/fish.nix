{pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      rb = "nh os switch ~/cryozenix";
      c = "cd ~/cryozenix && hx .";
      nfu = "nix flake update";
      s = "ragenix -e";
      d = "sudo xh --pretty ALL -d";
    };
    # generateCompletions = false;
  };
  home.packages = with pkgs; [
    fishPlugins.tide
    fishPlugins.forgit
    fishPlugins.autopair
    nitch
  ];
}
