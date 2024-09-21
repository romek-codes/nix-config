{ pkgs, lib, ... }:

let
  username = "romek";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  packages = with pkgs; [
    any-nix-shell # fish & zsh support for nix shell
    audacious # simple music player
    bazecor # configuration software for the dygma defy keyboard
    bottom # alternative to htop & ytop
    dig # dns command-line tool
    docker-compose # docker manager
    duf # disk usage/free utility
    eza # a better `ls`
    fd # "find" for files
    gimp # gnu image manipulation program
    hyperfine # command-line benchmarking tool
    bruno # rest client
    jmtpfs # mount mtp devices
    killall # kill processes by name
    libreoffice # office suite
    lnav # log file navigator on the terminal
    ncdu # disk space info (a better du)
    nitch # minimal system information fetch
    nix-output-monitor # nom: monitor nix commands
    nyancat # the famous rainbow cat!
    ranger # terminal file explorer
    ripgrep # fast grep
    screenkey # shows keypresses on screen
    tdesktop # telegram messaging client
    tree # display files in a tree view
    vlc # media player
    xsel # clipboard support (also for neovim)
    lazygit # my preferred way of interacting with git (i'm lazy)
  ];
in
{
  programs.home-manager.enable = true;

  imports = lib.concatMap import [
    ../modules
    ../scripts
    ../themes
    ./programs.nix
    ./services.nix
  ];

  xdg = {
    inherit configHome;
    enable = true;
  };

  home = {
    inherit username homeDirectory packages;

    sessionVariables = {
      BROWSER = "${lib.exe pkgs.firefox-beta-bin}";
      DISPLAY = ":0";
      EDITOR = "lvim";
      # https://github.com/NixOS/nixpkgs/issues/24311#issuecomment-980477051
      GIT_ASKPASS = "";
    };
  };

  # restart services on change
  systemd.user.startServices = "sd-switch";

  # notifications about home-manager news
  news.display = "silent";
}
