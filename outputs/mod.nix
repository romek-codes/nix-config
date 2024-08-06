{ inputs, system, extraSpecialArgs, ... }:

{
  home-manager = {
    inherit extraSpecialArgs;
    useGlobalPkgs = true;

    # sharedModules = [
    #   inputs.neovim-flake.homeManagerModules.${system}.default
    # ];

    users.romek = import ../home/wm/xmonad/home.nix;
  };
}
