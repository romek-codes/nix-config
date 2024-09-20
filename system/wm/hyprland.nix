{ pkgs, lib, ... }:

{
  programs = {
    dconf.enable = true;
    hyprland.enable = true;
  };

  # tty service config
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };


  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  # nice but buggy: https://github.com/rharish101/ReGreet/issues/45
  programs.regreet = {
    enable = false;
    settings = (lib.importTOML ./regreet.toml) // {
      background = {
        path = ../imgs/hyprland.png;
      };
    };
  };



  services = {
    # Bluetooth manager
    blueman.enable = true;

    # GTK theme config
    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };

    # User's credentials manager
    gnome.gnome-keyring.enable = true;

    # Init session with hyprland
    greetd = {
      enable = true;
      settings = rec {
        regreet_session = {
          command = "${lib.exe pkgs.cage} -s -- ${lib.exe pkgs.greetd.regreet}";
          user = "greeter";
        };
        tuigreet_session =
          let
            session = "${pkgs.hyprland}/bin/Hyprland";
            tuigreet = "${lib.exe pkgs.greetd.tuigreet}";
          in
          {
            command = "${tuigreet} --time --remember --cmd ${session}";
            user = "greeter";
          };
        default_session = tuigreet_session;
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # Prerequisite for screensharing
      wireplumber.enable = true;
    };

    # Allows Hyprland to run without root privileges
    seatd.enable = true;

    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ]; 
          settings = {
          main = {
            capslock = "layer(number)";
          };
          number = {
            u = "1";
            i = "2";
            o = "3";
            j = "4";
            k = "5";
            l = "6";
            m = "7";
            "," = "8";
            "." = "9";
            semicolon = "0";
          };
          arrows = {
            h = "left";
            j = "down";
            k = "up";
            l = "right";
          };
          };
        };
      };
    };

    # photoprism = {
    #   enable = true;
    #   port = 2342;
    #   originalsPath = "/var/lib/private/photoprism/originals";
    #   address = "0.0.0.0";
    #   settings = {
    #     PHOTOPRISM_ADMIN_USER = "admin";
    #     PHOTOPRISM_ADMIN_PASSWORD = "admin";
    #     PHOTOPRISM_DEFAULT_LOCALE = "en";
    #     PHOTOPRISM_DATABASE_DRIVER = "mysql";
    #     PHOTOPRISM_DATABASE_NAME = "photoprism";
    #     PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
    #     PHOTOPRISM_DATABASE_USER = "photoprism";
    #     PHOTOPRISM_SITE_TITLE = "Romek's PhotoPrism";
    #     PHOTOPRISM_NSFW_UPLOAD = "true";
    #   };
    # };

    # Not yet there.
    # immich = {
    #   enable = true;
    #   # environment.IMMICH_MACHINE_LEARNING_URL = "http://localhost:3003";
    # };

    syncthing = {
        enable = true;
        user = "romek";
        dataDir = "/home/romek/Documents";    # Default folder for new synced folders
        configDir = "/home/romek/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
  };

  # This helps with palm rejection when using keyd
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1"; 
  };
}
