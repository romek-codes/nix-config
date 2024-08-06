{ lib, pkgs, ... }:

let
  # plugins = pkgs.tmuxPlugins // pkgs.callPackage ./custom-plugins.nix { };
  tmuxConf = lib.readFile ./default.conf;
in
{
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    extraConfig = tmuxConf;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "a";
    terminal = "screen-256color";
  };
}
