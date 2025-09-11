# NixOS Config!

## Just

```just
just # check la flake
just nix # switch la config (autodetect darwin ou nixos)
just n test -a # custom arguements
```

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
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#<hostname>
# OR

sudo darwin-rebuild switch --flake .#<hostname>
```
