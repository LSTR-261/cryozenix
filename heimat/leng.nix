{
  imports = [
    ./common
    ./modules
  ];

  modules = {
    # COMMAND LINE TOOLS
    cli = true; # DEFAULT
    # GRAPHICAL/DESKTOP
    desktop = true;
    theming = true;
  };
}
