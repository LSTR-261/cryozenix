# {pkgs, ...}:
{
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  modules = {
    theming.theme = "gruvbox-dark-medium";
    nvidia = true;
  };
  # environment.systemPackages = with pkgs; [];
  services.printing.enable = true;
}
