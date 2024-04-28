{ inputs, pkgs, ... }:

{
  imports = [ inputs.anyrun.homeManagerModules.default ];
  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        inputs.anyrun.packages.${pkgs.system}.applications
      ];

      y = { absolute = 400; };
      width = { absolute = 512; };

      closeOnClick = true;
      hidePluginInfo = true;
    };
    
    extraCss = ''
      #window {
        background-color: rgba(0, 0, 0, 0.5);
      }

      box#main {
        border-radius: 8px;
        background-color: @theme_bg_color;
      }
    '';
  };
}
