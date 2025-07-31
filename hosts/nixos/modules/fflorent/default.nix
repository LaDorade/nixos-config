{pkgs, lib, ...}:
pkgs.stdenv.mkDerivation rec {
  pname = "mon-theme";
  version = "1.2.3";

  src = pkgs.fetchFromGitHub {
    owner = "KoroSensei10";
    repo = "fflorent";
    rev = "c0a02f161069085516d0e11a3eccdb0a6af0eae9";
  };

  # nativeBuildInputs = [ plymouth ];

  installPhase = ''
    mkdir -p $out/share/plymouth/themes/fflorent
    cp $src/* $out/share/plymouth/themes/fflorent/
    find $out/share/plymouth/themes/fflorent -name \*.plymouth -exec sed -i "s@\/usr\/@$out\/@" {} \; # Adjust paths to point to the nix derivation
  '';

  meta = with lib; {
    description = "F Florent !";
    platforms = platforms.linux;
  };
}

