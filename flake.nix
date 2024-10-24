{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        "${self}/hosts/default/configuration.nix"
        inputs.home-manager.nixosModules.default
      ];
    };
    homeConfiguratinos.default = home-manager.lib.homeManagerConfigurations {
      extraSpecialArgs = { inherit inputs;};
      modules = [
        "${self}/hosts/default/home.nix"
      ];
    };
  };
}
