{ config, pkgs, ... }:

{
  imports = [
    ../shared

    ./hyprland
  ];

  home.username = "scarey"; 
  home.homeDirectory = "/home/scarey";

  programs.gnome-terminal.profile.default.font = "JetBrainsMono";
    
  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}

