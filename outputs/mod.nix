{ inputs, system, extraSpecialArgs, ... }:

{
  home-manager = {
    inherit extraSpecialArgs;
    useGlobalPkgs = true;

    sharedModules = [
      # inputs.neovim-flake.homeManagerModules.${system}.default
      # inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];

    users.romek = import ../home/wm/xmonad/home.nix;
  };
}
