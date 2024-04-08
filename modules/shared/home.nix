{ config, pkgs, ... }:

{
  imports = [
    ./neovim
  ];

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
