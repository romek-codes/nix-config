{ pkgs, specialArgs, ... }:

let
  inherit (specialArgs) hidpi;
  fontSize = if hidpi then "14" else "10";
in
{
  # lightweight wayland terminal emulator
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        shell = "${pkgs.zsh}/bin/zsh";
        font = "JetBrainsMono Nerdfont:size=${fontSize}";
        pad = "6x6";
        dpi-aware = "yes";
        selection-target = "both";
      };
      colors = {
        # alpha = 0.5;
        alpha = 1;
        background = "1A1B26";
        foreground = "C0CAF5";
      };
    };
  };
}
