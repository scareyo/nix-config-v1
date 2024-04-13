{
  description = "A scarey flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Nix User Repository
    nur.url = github:nix-community/NUR;
    
    # Nix Darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, nur, nix-darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, home-manager, ... }@inputs: {
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

          { nixpkgs.overlays = [ nur.overlay ]; }

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.scarey = import ./modules/darwin/home.nix;
          }

          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "scarey";

              taps = {
                "homebrew/homebrew-bundle" = homebrew-bundle;
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
              };

              mutableTaps = false;
            };
          }
        ];
      };
    };
  };
}
