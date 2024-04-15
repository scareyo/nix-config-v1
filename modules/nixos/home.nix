{ config, pkgs, ... }:

{
  imports = [
    ../shared/home.nix
  ];

  home.username = "scarey"; 
  home.homeDirectory = "/home/scarey";

  programs.gnome-terminal.profile.default.font = "JetBrainsMono";
}

