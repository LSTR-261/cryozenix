{
  pkgs,
  username,
  ...
}: {
  stylix = {
    enable = true;
    polarity = "dark";
  };
  qt.enable = true;
  gtk.enable = true;
}
