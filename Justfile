deploy:
  {{ if os() == "macos" { "darwin" } else { "nixos" } }}-rebuild switch --flake .

debug:
  {{ if os() == "macos" { "darwin" } else { "nixos" } }}-rebuild switch --flake . --show-trace --verbose

gc:
  sudo nix-collect-garbage --delete-old
