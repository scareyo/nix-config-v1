{ ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      debug.disable_logs = false;
      debug.enable_stdout_logs = true;
      "$mod" = "SUPER";
      bind = [
        "$mod, F, exec, firefox"
        "$mod, RETURN, exec, kitty"
      ];
    };
  };
}
