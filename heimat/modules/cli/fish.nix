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
    shellAliases = {
      tbd = ''set url $argv[1]; set subdir $argv[2]; set target_dir "storage/$subdir"; set temp_zip_file "/tmp/(basename $url)"; xh -b $url --output $temp_zip_file; mkdir -p $target_dir; unzip -q -o $temp_zip_file -d $target_dir; sudo chown -R root:media $target_dir; sudo chmod -R 755 $target_dir; rm -f $temp_zip_file'';
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
