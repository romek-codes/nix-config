{ pkgs, config, lib, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Collisions out the ass i guess i'll use mason at least it works.
  # home.packages = with pkgs.vimPlugins; [
    # AstroNvim core plugins
    # astrocore
    # astrolsp
    # astroui
    # mason-null-ls-nvim
    # mason-nvim-dap-nvim

    # Additional required dependencies
    # mason-nvim
    # neodev-nvim
    # nvim-lspconfig
    # plenary-nvim
    # telescope-nvim
    # which-key-nvim
  # ];

  # How do i make this dynamic? Hardcoded doesn't seem so nice but it's the only way i can make the symlink work.
  # Relevant issue: https://github.com/nix-community/home-manager/issues/3514
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/home/programs/astronvim/template";
}
