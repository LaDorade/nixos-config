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
nécessite la configuration suivante sur la machine qui build:
`boot.binfmt.emulatedSystems = [ "aarch64-linux" ];`

## NixOS

### Cross compile vers le PI

```sh
nixos-rebuild switch --sudo --ask-sudo-password --target-host pi@192.168.1.79 --flake .#pi
```

## Nix-Darwin

```sh
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#<hostname>
# OR

sudo darwin-rebuild switch --flake .#<hostname>
```
