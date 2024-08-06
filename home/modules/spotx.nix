{ lib, stdenv, fetchFromGitHub, bash, coreutils, ... }:

stdenv.mkDerivation {
  pname = "spotx";
  version = "1.0.0"; 

  src = fetchFromGitHub {
    owner = "SpotX-Official";
    repo = "SpotX-Bash";
    rev = "main"; # You might want to pin this to a specific commit or tag
    sha256 = ""; # You'll need to fill this in
  };

  buildInputs = [ bash coreutils ];

  installPhase = ''
    mkdir -p $out/bin
    cp install.sh $out/bin/spotx
    chmod +x $out/bin/spotx
  '';

  meta = with lib; {
    description = "A bash script to install SpotX";
    homepage = "https://github.com/SpotX-Official/SpotX-Bash";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
