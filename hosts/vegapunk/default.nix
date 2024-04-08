{ pkgs, ... }:

{
  imports = [ 
    ../../modules/darwin/packages.nix
  ];

  # Enable experimental features
  nix.settings.experimental-features = "nix-command flakes";

  users.users.scarey = {
    name = "scarey";
    home = "/Users/scarey";
  };

  # Set host platform
  nixpkgs.hostPlatform = "aarch64-darwin";
 
  nixpkgs.config.allowUnfree = true;

  services.nix-daemon.enable = true;

  programs.zsh.enable = true;

  system.stateVersion = 4;
}
