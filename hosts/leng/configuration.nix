{
  pkgs,
  inputs,
  system,
  ...
}: {
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  modules = {
    theming = true;
    server = true;
    nvidia = true;
  };
  documentation.man.generateCaches = false;
  environment.systemPackages = with pkgs; [
    inputs.ragenix.packages.${system}.default
    openssl
  ];
}
