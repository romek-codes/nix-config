{ pkgs, ... }:

{
  programs.rofi= {
    enable = true;
    # calc is short for calculator
    plugins = with pkgs; [ rofi-calc  ]; # rofi-emoji
    # terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ./theme.rafi;
    package = pkgs.rofi-wayland;
  };

  # for rofi-emoji to insert emojis directly
  # home.packages = [ pkgs.xdotool ];
}

