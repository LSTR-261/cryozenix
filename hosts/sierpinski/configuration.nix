# {pkgs, ...}:
{
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  modules = {
    theming.theme = "gruvbox-dark-medium";
    server.enable = true;
    server.domains = ["*.s.lstr-261.eu"];
    nvidia = true;
  };
  # environment.systemPackages = with pkgs; [];
}
