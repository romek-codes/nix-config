{
  lib,
  stdenv,
  fetchurl,
}:
stdenv.mkDerivation {
  pname = "laravel-dev-tools";
  version = "1.0.0";

  src = fetchurl {
    url = "https://github.com/haringsrob/laravel-dev-tools/releases/download/1.0.0/laravel-dev-tools";
    sha256 = ""; # Add the hash here
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/laravel-dev-generators
    chmod +x $out/bin/laravel-dev-generators
  '';
}
