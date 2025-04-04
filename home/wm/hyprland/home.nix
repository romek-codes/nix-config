{
  pkgs,
  lib,
  inputs,
  ...
}: let
  fontPkgs = with pkgs; [
    font-awesome # awesome fonts
    material-design-icons # fonts with glyphs
    nerd-fonts.jetbrains-mono
  ];

  audioPkgs = with pkgs; [
    paprefs # pulseaudio preferences
    pasystray # pulseaudio systray
    pavucontrol # pulseaudio volume control
    playerctl # music player controller
    pulsemixer # pulseaudio mixer
  ];

  packages = with pkgs;
    [
      brightnessctl # control laptop display brightness
      nemo # file manager
      loupe # image viewer
      grim # screenshots
      grimblast # screenshot program from hyprland
      libnotify # notifications
      nix-search # faster nix search client
      wl-clipboard # clipboard support
      kdePackages.xwaylandvideobridge # screensharing bridge
      vesktop # Discord modded client with wayland support
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
      wlsunset # screen color temp manager (like f.lux)
      pass # for some password, like todoist.nvim api key
      nwg-look # gtk3 settings
      tldr # tldr manpages
      peazip # for zip and rar files
      amdvlk
      wget
      gcc
      rustc
      cargo
      nil
      unzip # some dev dep
      gnumake
      gcc
      php # Laravel <3
      php83Packages.composer
      tailwindcss-language-server # Tailwind LSP
      nodejs
      dbeaver-bin # DBMS
      croc # File transfer
      # For use with my optmz python script.
      imagemagick # Image optimization
      ffmpeg # Video optimization
      aider-chat # AI
      copyq # Clipboard history
      godot_4 # Gamedev
      linux-wallpaperengine # wallpaper engine for linux?

      rofi-rbw-wayland # Rofi frontend for Bitwarden
      rbw # Bitwarden CLI (needed for rofi-rbw)
      pinentry # Needed by rbw

      # LSPs, linters etc.
      statix
      nixd
      alejandra
      deadnix
      lua-language-server
      vscode
      gparted # partitions
      gnome-disk-utility # mounting iso
    ]
    ++ fontPkgs
    ++ audioPkgs;

  lib-grimblast = lib.exe pkgs.grimblast;
  wpctl = "${pkgs.wireplumber}/bin/wpctl";

  scripts = pkgs.callPackage ./scripts.nix {};

  workspaceConf = {monitor}: ''
    workspace=1,on-created-empty:firefox-beta
    workspace=2,on-created-empty:footclient -e
    workspace=10,on-created-empty:footclient -e btm
  '';
in {
  imports = [
    ../../shared
    ../../programs/foot
    ../../programs/hyprlock
    ../../programs/hyprpaper
    ../../programs/pyprland
    ../../programs/copyq
    ../../programs/waybar
    ../../services/hypridle
    ../../services/glance
    ../../programs/rofi
    ../../programs/spicetify-nix
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
        default = ["hyprland"];
      };
      hyprland = {
        default = ["gtk" "hyprland"];
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "default-web-browser" = ["firefox.desktop"];
      "text/html" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "x-scheme-handler/about" = ["firefox.desktop"];
      "x-scheme-handler/unknown" = ["firefox.desktop"];
    };
  };

  xdg.configFile."hypr/monitors.conf".text = ''
    # meeting raum why tf is the tv horizontal? 
    monitor=desc:AU Optronics 0xD291,1920x1200@60.03,0x0,1
    # When having horizontal monitor to the left
    # monitor=desc:Acer Technologies X28 ##GTIYMxgwAAt+,2560x1440@144.0,1920x0,1

    # When having vertical monitor to the left
    monitor=desc:Acer Technologies X28 ##GTIYMxgwAAt+,2560x1440@144.0,1080x0,1.0

    monitor=desc:Iiyama North America PL2288H 0x01010101,1920x1080@60.0,0x0,1.0
    monitor=desc:Iiyama North America PL2288H 0x01010101,transform,1


    # monitor = DP-1,2560x1440@144.00Hz,1080x0,1 # Old PC Main
    monitor = desc:California Institute of Technology 0x1402,1920x1200@90.00Hz,0x0,1.25 # laptop-built in
    monitor = desc:CTV CTV 0x00000001,preferred,1920x0,1
    monitor = desc:Samsung Electric Company SAMSUNG 0x00000001,preferred,1920x0,1
    monitor = desc:Avolites Ltd HDTV,preferred,1920x0,1

    monitor=,preferred,auto,1
  '';

  programs.hypr-binds = {
    enable = true;
    settings.dispatch = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    extraConfig =
      (builtins.readFile ./hyprland.conf)
      + ''
        bindd=SUPER,F1,Show keybindings,exec,hypr-binds
        bindd=SUPER,P,Launch a program,exec,${lib.exe pkgs.rofi-wayland} -modes run,window -show run
        bindd=SUPER,TAB,Show open windows,exec,${lib.exe pkgs.rofi-wayland} -modes run,window -show window
        bindd=SUPER,C,Color picker,exec,${lib.exe pkgs.hyprpicker} --autocopy
        bindd=SUPER,A,Screenshot area,exec,${lib-grimblast} copysave area
        bindd=SUPER,S,Screenshot screen(s),exec,${lib-grimblast} copysave screen
        bindd=SUPERCTRL,L,Lock screen,exec,${lib.exe pkgs.hyprlock}
        # audio volume bindings
        binddel=,XF86AudioRaiseVolume,Raise volume 󰝝 ,exec,${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+
        binddel=,XF86AudioLowerVolume,Lower volume 󰝞 ,exec,${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-
        binddl=,XF86AudioMute,Toggle mute 󰝟 ,exec,${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle

        ${workspaceConf {monitor = "${scripts.extMonitor}";}}

        exec-once=${lib.exe scripts.monitorInit}
        exec-once=${lib.exe pkgs.hyprland-monitor-attached} ${lib.exe scripts.monitorAdded} ${lib.exe scripts.monitorRemoved}
        exec-once=${lib.exe pkgs.hyprpaper}
        exec-once=${pkgs.pyprland}/bin/pypr
        exec-once=${pkgs.blueman}/bin/blueman-applet
        exec-once=${pkgs.networkmanagerapplet}/bin/nm-applet --sm-disable --indicator
        exec-once=${lib.exe pkgs.pasystray}
      '';
    plugins = [
      # inputs.hyprsplit.packages.${pkgs.system}.hyprsplit
      inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
      # inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix
    ];
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    xwayland.enable = true;
  };
}
