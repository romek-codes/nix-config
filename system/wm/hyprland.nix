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
            capslock = "toggle(number)";
          };
          number = {
            a = "1";
            s = "2";
            d = "3";
            f = "4";
            g = "5";
            h = "6";
            j = "7";
            k = "8";
            l = "9";
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
  };

  # This helps with palm rejection when using keyd
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';
}
