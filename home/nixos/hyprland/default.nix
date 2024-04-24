{ inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];
    settings = {
      debug = {
        disable_logs = false;
      };

      "$mod" = "SUPER";
      bind = [
        "$mod, F, exec, firefox"
        "$mod, RETURN, exec, kitty"
      ];

      plugin = {
        hyprbars = {
          bar_height = 20;
        };
      };

      monitor = [
        "HDMI-A-1,3440x1440@85,1080x240,1"
        "DP-1,1920x1080@144,0x0,1,transform,1"
      ];
    };
  };
}
