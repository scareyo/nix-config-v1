{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; 
    let packages = import ../shared/packages.nix { inherit pkgs; }; in
    packages ++ [
      alt-tab-macos
      vscode
    ];
}

