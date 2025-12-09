{
  config,
  pkgs,
  ...
}: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  services.gvfs.enable = true;
  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
  ];

  boot.supportedFilesystems = ["ntfs"];
}
