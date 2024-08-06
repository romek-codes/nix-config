{ pkgs, ... }:

{
  home.packages = [ pkgs.hyprpaper ];
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=${./astronaut-blackhole.jpg}
    wallpaper=,${./astronaut-blackhole.jpg}
    ipc=off
  '';
}
