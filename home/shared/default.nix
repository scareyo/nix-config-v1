{ config, pkgs, ... }:

{
  imports = [
    ./kitty
    ./neovim
    ./zsh
  ];
  
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "Meslo" ]; })
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

  programs.gpg.enable = true;

  home.sessionVariables = rec {
    GPG_TTY = "$(tty)";
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
