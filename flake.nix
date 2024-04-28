{
  description = "A scarey flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Nix User Repository
    nur.url = github:nix-community/NUR;
    
    # Nix Darwin
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Agenix
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS Hardware
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # Anyrun
    anyrun.url = "github:Kirottu/anyrun";

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

  outputs = inputs@{ self, agenix, home-manager, homebrew-bundle, homebrew-cask, homebrew-core, nix-darwin, nix-homebrew, nixos-hardware, nixpkgs, nur, ... }: {

    nixosConfigurations.teseuka =
      let
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/teseuka

          # Disable NVIDIA
          nixos-hardware.nixosModules.common-gpu-nvidia-disable
            
          { nixpkgs.overlays = [ nur.overlay ]; }

          agenix.nixosModules.default
          { environment.systemPackages = [ agenix.packages.x86_64-linux.default ]; }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.scarey = import ./home/nixos;
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      in
      nixpkgs.lib.nixosSystem { inherit system modules specialArgs; };

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
            home-manager.users.scarey = import ./home/darwin;
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
