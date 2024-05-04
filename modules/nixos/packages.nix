{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; 
    let packages = import ../shared/packages.nix { inherit pkgs; }; in
    packages ++ [
      cider
      firefox
      gnome.gnome-tweaks
      prismlauncher
      vesktop
    ];
}
