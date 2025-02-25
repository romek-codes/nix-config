{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # Games and gaming-related packages
    (lutris.override {
      extraPkgs = pkgs: [
        fuse
      ];
    })
    pcsx2
    waydroid # android emulator
    linux-wallpaperengine # wallpaper engine for linux
    godot_4 # Gamedev

    # GPU drivers that might be gaming-specific
    amdvlk
  ];
}
