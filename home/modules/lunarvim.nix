{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.lunarvim;
in {
  options.programs.lunarvim = {
    enable = mkEnableOption "LunarVim";
    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = "Extra configuration to add to config.lua";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lunarvim
    ];

    xdg.configFile."lvim/config.lua".text = cfg.extraConfig;

    programs.neovim.enable = true;  # LunarVim requires Neovim
  };
}
