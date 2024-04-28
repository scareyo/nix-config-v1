{ inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      debug = {
        disable_logs = false;
      };

      "$mod" = "SUPER";
      bind = [
        "$mod, Q, killactive"
        "$mod, F, exec, firefox"
        "$mod, RETURN, exec, kitty"
        "$mod, R, exec, anyrun"
      ];

      exec = [
        "eww daemon"
        "eww open example"
      ];

      exec-once = [
        "exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
      ];

      general = {
        "col.active_border" = "rgb(89b4fa)";
        "col.inactive_border" = "rgb(11111b)";
        gaps_out = "50, 20, 20, 20";
        hover_icon_on_border = false;
        no_cursor_warps = true;
        resize_on_border = true;
      };

      input = {
        off_window_axis_events = 0;
      };

      decoration = {
        rounding = 8;
      };

      workspace = [
        "1, monitor:desc:BNQ BenQ XL2720Z 19E00634SL0, persistent:true, gapsout:20"
        "2, monitor:desc:LG Electronics 34GK950F 0x00067BE6, persistent:true"
        "3, monitor:desc:LG Electronics 34GK950F 0x00067BE6, persistent:true"
        "4, monitor:desc:LG Electronics 34GK950F 0x00067BE6, persistent:true"
        "5, monitor:desc:LG Electronics 34GK950F 0x00067BE6, persistent:true"
      ];

      monitor = [
        "HDMI-A-1,3440x1440@85,1080x240,1"
        "DP-1,1920x1080@144,0x0,1,transform,1"
      ];
    };
  };
}
