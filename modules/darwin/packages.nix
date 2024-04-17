{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; 
  let packages = import ../shared/packages.nix { inherit pkgs; }; in
  packages ++ [
    alt-tab-macos
    discord
    vscode
  ];

  homebrew = {
    enable = true;
    casks = [
      "firefox"
      "steam"
    ];
  };

  # Copying applications so they appear in spotlight
  # Upstream issue: https://github.com/LnL7/nix-darwin/issues/214
  system.activationScripts.applications.text = lib.mkForce ''
    echo "Copying applications" >&2
    nix_apps="/Applications/Nix Apps"

    # Delete the directory to remove old links
    rm -rf "$nix_apps"
    mkdir -p "$nix_apps"

    find ${config.system.build.applications}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read src; do
            echo "Copying $src to $nix_apps" >&2
            cp -r "$src" "$nix_apps/"
        done
  '';
}

