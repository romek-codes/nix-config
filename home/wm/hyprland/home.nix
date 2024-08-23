{ pkgs, lib, inputs, ... }:

let
  fontPkgs = with pkgs; [
    font-awesome # awesome fonts
    material-design-icons # fonts with glyphs
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "Iosevka"
      ];
    })
  ];

  audioPkgs = with pkgs; [
    paprefs # pulseaudio preferences
    pasystray # pulseaudio systray
    pavucontrol # pulseaudio volume control
    playerctl # music player controller
    pulsemixer # pulseaudio mixer
  ];

  packages = with pkgs; [
    brightnessctl # control laptop display brightness
    nemo # file manager
    loupe # image viewer
    grim # screenshots
    grimblast # screenshot program from hyprland
    libnotify # notifications
    nix-search # faster nix search client
    wl-clipboard # clipboard support
    xwaylandvideobridge # screensharing bridge
    vesktop # Discord modded client with wayland support
    spotify # Spotify, duh
    calibre # Ebook management software
    qdirstat # Storage management
    obsidian # Notes with obsidian.nvim <3
    onlyoffice-bin # Office stuff
    thefuck # Funny and pretty useful cli utility
    kdePackages.kdenlive # Video editor
    kdePackages.breeze # Dark mode for kdenlive
    solaar # Logitech device manager
    cyme # lsusb and other utils
    usb-modeswitch # turning devices off and on in cli
    hyprpicker # color picker
    amdvlk
    wget
    gcc
    rustc
    cargo
    nil
    unzip
    gnumake
    gcc

    # Games
    (lutris.override {
       extraPkgs = pkgs: [
         fuse
       ];
    })
    pcsx2
  ] ++ fontPkgs ++ audioPkgs;

  gblast = lib.exe pkgs.grimblast;
  wpctl = "${pkgs.wireplumber}/bin/wpctl";

  scripts = pkgs.callPackage ./scripts.nix { };

  workspaceConf = { monitor }: ''
    workspace=1,on-created-empty:firefox-beta
    workspace=2,on-created-empty:footclient -e
    workspace=10,on-created-empty:footclient -e btm
  '';

in
{
  imports = [
    ../../shared
    ../../programs/foot
    ../../programs/hyprlock
    ../../programs/hyprpaper
    ../../programs/pyprland
    ../../programs/waybar
    ../../services/hypridle
    ../../programs/rofi
  ];

  home = {
    inherit packages;
    stateVersion = "23.05";

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      SHELL = "${lib.exe pkgs.zsh}";
      MOZ_ENABLE_WAYLAND = 1;
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland;xcb";
    };
  };

  fonts.fontconfig.enable = true;

  # e.g. for slack, signal, etc
  xdg.configFile."electron-flags.conf".text = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
  '';

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [ "hyprland" ];
      };
      hyprland = {
        default = [ "gtk" "hyprland" ];
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
  };

    xdg.configFile."hypr/monitors.conf".text = ''
      # TODO: Figure out how to handle this automatically
      # PC
      monitor=HDMI-A-1,1920x1080,0x43,1,transform,1 # Iiyama vertical
      monitor=DP-1,preferred,1080x0,1
      # Laptop
      # monitor=eDP-1,preferred,1080x0,1
      # monitor=DP-2,1920x1080,0x43,1,transform,1 # Iiyama vertical
      monitor=,preferred,auto,1
    '';

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    extraConfig = (builtins.readFile ./hyprland.conf) + ''
      bind=SUPER,P,exec,${lib.exe pkgs.rofi-wayland} -modes run,window -show run
      bind=SUPER,TAB,exec,${lib.exe pkgs.rofi-wayland} -modes run,window -show window
      bind=SUPER,C,exec,${lib.exe pkgs.hyprpicker} --autocopy
      bind=SUPER,A,exec,${gblast} save area
      bind=SUPER,S,exec,${gblast} save screen
      bind=SUPERCTRL,L,exec,${lib.exe pkgs.hyprlock}
      # audio volume bindings
      bindel=,XF86AudioRaiseVolume,exec,${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bindel=,XF86AudioLowerVolume,exec,${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindl=,XF86AudioMute,exec,${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle

      ${workspaceConf { monitor = "${scripts.extMonitor}"; }}

      exec-once=${lib.exe scripts.monitorInit}
      exec-once=${lib.exe pkgs.hypr-monitor-attached} ${lib.exe scripts.monitorAdded} ${lib.exe scripts.monitorRemoved}
      exec-once=${lib.exe pkgs.hyprpaper}
      exec-once=${pkgs.pyprland}/bin/pypr
      exec-once=${pkgs.blueman}/bin/blueman-applet
      exec-once=${pkgs.networkmanagerapplet}/bin/nm-applet --sm-disable --indicator
      exec-once=${lib.exe pkgs.pasystray}
    '';
    plugins = [
      inputs.hyprsplit.packages.${pkgs.system}.hyprsplit
      # inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix
    ];
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    xwayland.enable = true;
  };
}
