{
  inputs,
  outputs,
  self,
  username,
  ...
}: {
  hostname,
  system ? "x86_64-linux",
}: let
  home = import "${self}/heimat/${hostname}.nix";
  conf = import "${self}/hosts/${hostname}";
  var = import "${self}/hosts/${hostname}/var.nix";
  specialArgs = {inherit inputs outputs hostname username system;} // var;
in
  inputs.nixpkgs.lib.nixosSystem {
    inherit specialArgs;
    modules = [
      conf
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager
      inputs.ragenix.nixosModules.default
      inputs.stylix.nixosModules.stylix
      {
        home-manager = {
          useUserPackages = true;
          extraSpecialArgs = specialArgs; # Pass down the echoes.
          users.${username}.imports = [home]; # Apply the user's specific persona matrix.
        };
      }
    ];
  }
