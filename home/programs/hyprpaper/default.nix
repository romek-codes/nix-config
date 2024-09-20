{ pkgs, ... }:

{
  home.packages = [ pkgs.hyprpaper ];
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=${./crow.png}
    wallpaper=,${./crow.png}
    ipc=off
  '';
}
