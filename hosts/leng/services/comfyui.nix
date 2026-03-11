{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [inputs.comfyui-nix.overlays.default];
  imports = [inputs.comfyui-nix.nixosModules.default];
  environment.systemPackages = [pkgs.comfy-ui-cuda];

  services.comfyui = {
    enable = true;
    gpuSupport = "cuda";
    enableManager = true;
    port = 8188;
    listenAddress = "0.0.0.0";
    openFirewall = true;
    # customNodes = {

    # };
  };

  services.caddy.virtualHosts."comfyui.lstr-261.eu".extraConfig = ''
    reverse_proxy leng.fritz.box:8188
  '';
}
