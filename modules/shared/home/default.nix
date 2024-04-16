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
    profiles.scarey = {
      isDefault = true;
      bookmarks = {};
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        ublock-origin
      ];
    };
  };

  programs.git = {
    enable = true;
    userName = "Samuel Carey";
    userEmail = "sam@scarey.me";
    signing = {
      key = null;
      signByDefault = true;
    };
    extraConfig = {
      diff.tool = "nvimdiff";
    };
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

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = rec {
    GPG_TTY = "$(tty)";
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
