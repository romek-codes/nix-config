{ pkgs, specialArgs, ... }:

let
  inherit (specialArgs) hidpi;
  fontSize = if hidpi then "12" else "10";
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
        pad = "0x0";
        dpi-aware = "yes";
        selection-target = "both";
      };
      colors = {
        # alpha = 0.5;
        alpha = 1;
        background = "0C0C0C";
        foreground = "f2f4f8";
      };
    };
  };
}
