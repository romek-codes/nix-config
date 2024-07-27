{ pkgs, ... }:

{
  home.packages = [ pkgs.hyprpaper ];
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=${./galaxy.jpg}
    wallpaper=,${./galaxy.jpg}
    ipc=off
  '';
}
