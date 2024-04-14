{ config, pkgs, ... }:

{
  imports = [
    ./kitty
    ./neovim
  ];
  
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          ublock-origin
        ];
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Samuel Carey";
    userEmail = "sam@scarey.me";
  };


  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
	"git"
      ];
    };
  };

  programs.gpg.enable = true;

  home.sessionVariables = rec {
    GPG_TTY = "$(tty)";
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
