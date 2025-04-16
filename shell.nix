# shell.nix
with import <nixpkgs> {};
let
  sops-nix = builtins.fetchTarball {
    url = "https://github.com/Mic92/sops-nix/archive/master.tar.gz";
  };
in
mkShell {
  # imports all files ending in .asc/.gpg
  sopsPGPKeyDirs = [ 
    "${toString ./.}/keys/hosts"
    "${toString ./.}/keys/users"
  ];
  
  nativeBuildInputs = [
    (pkgs.callPackage sops-nix {}).sops-import-keys-hook
  ];
}
