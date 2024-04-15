{ ... }:

{
  system.defaults.dock = {
    autohide = true;
    show-recents = false;
    persistent-apps = [
      "/Applications/Firefox.app"
      "/Applications/Nix Apps/kitty.app"
      "/System/Applications/Mail.app"
      "/Applications/Nix Apps/Discord.app"
    ];

    # Hot Corner - Top Left - Mission Control
    wvous-tl-corner = 2;
  };
}
