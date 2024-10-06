{ pkgs, ... }:

{
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

    initrd.kernelModules = [ "amdgpu" ];
  };

  networking = {
    hostName = "lenovo-yoga";
  #  interfaces = {
  #    eno1.useDHCP = true;
  #    wlp1s0.useDHCP = true;
  #  };
  };

  services.sysprof.enable = true;

  # TODO: Will not be needed after switch to immich from photoprism.
  # Modify dataDir to folder where photoprism/mysql dir is located on lenovo-yoga.
  # services.mysql = {
  #   enable = true;
  #   package = pkgs.mariadb; 
  #   dataDir = "/SyncthingMain/Personal/media/photoprism/mysql";
  #   ensureDatabases = [ "photoprism" ];
  #   ensureUsers = [ {
  #     name = "photoprism";
  #     ensurePermissions = {
  #       "photoprism.*" = "ALL PRIVILEGES";
  #     };
  #   } ];
  # };

  services.xserver = {
    videoDrivers = [ "amdgpu" ];


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
      { x = 2048; y = 1152; }
      { x = 1920; y = 1080; }
      { x = 2560; y = 1440; }
      { x = 3072; y = 1728; }
      { x = 3840; y = 2160; }
    ];
  };


  services.tlp.enable = true;
  powerManagement.enable = true;

  programs = {
    # I guess this can't be installed using home-manager, at least not in a straight forward way.
    # https://github.com/nix-community/home-manager/issues/4314
    steam = {
      enable = true;
      remotePlay.openFirewall = true; 
      dedicatedServer.openFirewall = true; 
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.03"; # Did you read the comment?
}
