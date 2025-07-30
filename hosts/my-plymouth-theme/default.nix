{pkgs, lib, ...}:
pkgs.stdenv.mkDerivation rec {
  pname = "mon-theme";
  version = "1.2.3";

  src = ./mon-theme;

  # nativeBuildInputs = [ plymouth ];

  installPhase = ''
    mkdir -p $out/share/plymouth/themes/mon-theme
    cp $src/* $out/share/plymouth/themes/mon-theme/
    find $out/share/plymouth/themes/mon-theme -name \*.plymouth -exec sed -i "s@\/usr\/@$out\/@" {} \; # Adjust paths to point to the nix derivation
  '';

  meta = with lib; {
    description = "Mon thème Plymouth personnalisé";
    platforms = platforms.linux;
  };
}

