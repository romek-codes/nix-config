{pkgs, ...}: {
  imports = [
    # Hardware scan
    ./hardware-configuration.nix
    ../../wm/hyprland.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # Use the systemd-boot EFI boot loader.
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

  };

  networking = {
    hostName = "work";
    extraHosts = ''
      127.0.0.1 local.apps.sx-oz.de
      ::1 local.apps.sx-oz.de localhost
    '';
  };

  networking = {
    # Enables wireless support and openvpn via network manager.
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
        networkmanager-openconnect
      ];
    };

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
  };

  services.sysprof.enable = true;

  services.xserver = {

    xrandrHeads = [
      {
        output = "HDMI-A-0";
        primary = true;
        monitorConfig = ''
          Modeline "1920x1080_30.00"  338.75  3840 4080 4488 5136  2160 2163 2168 2200 -hsync +vsync
          Option "PreferredMode" "3840x2160_30.00"
          Option "Position" "0 0"
        '';
      }
      {
        output = "eDP";
        primary = false;
        monitorConfig = ''
          Option "PreferredMode" "1920x1080"
          Option "Position" "0 0"
        '';
      }
    ];

    resolutions = [
      {
        x = 2048;
        y = 1152;
      }
      {
        x = 1920;
        y = 1080;
      }
      {
        x = 2560;
        y = 1440;
      }
      {
        x = 3072;
        y = 1728;
      }
      {
        x = 3840;
        y = 2160;
      }
    ];
  };

  services.tlp.enable = true;
  powerManagement.enable = true;

  environment.systemPackages = with pkgs; [
    slack
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.03"; # Did you read the comment?
}
