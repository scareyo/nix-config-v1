{ config, pkgs, ... }:

{
  imports = [
    ../shared/home.nix
  ];

  home.username = "scarey"; 
  home.homeDirectory = "/Users/scarey";
}
