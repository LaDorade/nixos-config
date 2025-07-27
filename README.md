# NixOS Config!

## Formatte les fichiers

```sh
nixfmt ./**/*
```

## NixOS

## Nix-Darwin

```sh
sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --flake .#<hostname>
# OR

sudo darwin-rebuild switch --flake .#<hostname>
```
