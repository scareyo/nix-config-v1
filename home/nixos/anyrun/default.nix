{ inputs, pkgs, ... }:

{
  imports = [ inputs.anyrun.homeManagerModules.default ];
  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        inputs.anyrun.packages.${pkgs.system}.applications
      ];

      closeOnClick = true;
      hidePluginInfo = true;
      width = { absolute = 400; };
    };
    
    extraCss = ''
      #window {
        background-color: rgba(0, 0, 0, 0);
      }

      box#main {
        border-radius: 8px;
        background-color: @theme_bg_color;
      }
    '';
  };
}
