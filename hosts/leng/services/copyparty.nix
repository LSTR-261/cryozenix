{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.copyparty.nixosModules.default];
  nixpkgs.overlays = [inputs.copyparty.overlays.default];
  environment.systemPackages = [pkgs.copyparty];
  services.copyparty = {
    enable = true;
    group = "media";
    settings = {
      i = "0.0.0.0";
      # xff-src = "leng.fritz.box";
      # xf-proto = "https";
    };
    accounts = {
      lstr-261.passwordFile = "${pkgs.writeText "copyparty" "277353"}";
    };
    volumes = {
      "/" = {
        path = "/storage";
        access.rwmda = "lstr-261";
        flags.chmod_f = 755;
      };
    };
  };
  services.caddy.virtualHosts."files.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:3923
  '';

  networking.firewall.allowedTCPPorts = [3923];
}
