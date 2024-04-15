{ ... }:

{
  imports = [
    ../shared/home
  ];

  home.username = "scarey"; 
  home.homeDirectory = "/Users/scarey";

  programs.firefox.package = null;
}
