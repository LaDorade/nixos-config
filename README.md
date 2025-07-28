# NixOS Config!

## Formatte les fichiers

```sh
nixfmt ./**/*
```

## Check si tout est bon

```sh
nix flake check
# TODO : en faire un hook de precommit
```

## NixOS

## Nix-Darwin

```sh
sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --flake .#<hostname>
# OR

sudo darwin-rebuild switch --flake .#<hostname>
```
