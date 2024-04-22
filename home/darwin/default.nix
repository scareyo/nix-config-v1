{ ... }:

{
  imports = [
    ../shared
  ];

  home.username = "scarey"; 
  home.homeDirectory = "/Users/scarey";

  programs.firefox.package = null;
}
