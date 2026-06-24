{
description = "Nix Hyprland Lua";

inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  helium = {
    url = "github:AlvaroParker/helium-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  noctalia = {
    url = "github:noctalia-dev/noctalia";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  mangowm = {
    url = "github:mangowm/mango";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};

outputs = inputs @ {
  self,
  nixpkgs,
  ...
}: {
  nixosConfigurations.nixos-dell = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [
      ./configuration.nix
      ./hardware-configuration.nix
      ./noctalia.nix
    ];
  };
};
}
