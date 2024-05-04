# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, pkgs, home-manager, ... }:

{
  imports = [ 
    ../../modules/nixos
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/packages.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    # Cachix
    substituters = [
      "https://hyprland.cachix.org"
      "https://anyrun.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices."luks-ca609995-42af-4bdb-b348-584b6bcf8001".device = "/dev/disk/by-uuid/ca609995-42af-4bdb-b348-584b6bcf8001";

    kernelModules = ["i2c-dev"];

    extraModprobeConfig = lib.mkDefault ''
      blacklist nouveau
      options nouveau modeset=0
    '';

    blacklistedKernelModules = lib.mkDefault [ "nouveau" "nvidia" ];
  };

  hardware.opengl.enable = true;

  networking.hostName = "teseuka"; # Define your hostname.

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
