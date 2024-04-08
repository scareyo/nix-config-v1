{
  description = "A scarey flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Nix Darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }@inputs: {
    nixosConfigurations.teseuka = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/teseuka

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.scarey = import ./modules/nixos/home.nix;
        }
      ];
    };
    darwinConfigurations = {
      system = "aarch64-darwin";
      vegapunk = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/vegapunk

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.scarey = import ./modules/darwin/home.nix;
          }
        ];
      };
    };
  };
}
