{
  description = "::CRYOZENIX::";
  inputs = {
    # ESSENTIAL
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    # DESKTOP
    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
    dms.url = "github:AvengeMedia/DankMaterialShell";
    dms.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    # SERVER
    ragenix.url = "github:yaxitech/ragenix";
    ragenix.inputs.nixpkgs.follows = "nixpkgs";
    copyparty.url = "github:9001/copyparty";
    copyparty.inputs.nixpkgs.follows = "nixpkgs";
    comfyui-nix.url = "github:utensils/comfyui-nix";
    comfyui-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, ...} @ inputs: let
    username = "lstr-261";
    hosts = [
      "leng"
      # "sierpinski"
      # "penrose"
    ];
    mkNixos = import ./lib/mkNixos.nix {
      inherit
        username
        inputs
        outputs
        self
        ;
    };
    inherit (self) outputs;
  in {
    nixosConfigurations =
      inputs.nixpkgs.lib.genAttrs hosts (hostname:
        mkNixos {inherit hostname;});
    overlays =
      import ./overlays {inherit inputs outputs;};
  };
}
