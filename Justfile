deploy:
  {{ if os() == "macos" { "darwin" } else { "nixos" } }}-rebuild switch --flake .

debug:
  {{ if os() == "macos" { "darwin" } else { "nixos" } }}-rebuild switch --flake . --show-trace --verbose

gc:
  sudo nix-collect-garbage --delete-old

init:
  {{ if os() == "macos" { "just _init-macos" } else { "" } }}

_init-macos:
  nix run nix-darwin -- switch --flake .
