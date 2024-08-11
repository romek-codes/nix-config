{ pkgs, config, ... }:

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

    # For obs virtual camera
    extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
    ];

    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    supportedFilesystems = [ "ntfs" ];

    };

  networking = {
    hostName = "meshify-pc";
  #  interfaces = {
  #    eno1.useDHCP = true;
  #    wlp1s0.useDHCP = true;
  #  };
  };

  services.sysprof.enable = true;

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
  security.polkit.enable = true;


  programs = {
    # I guess this can't be installed using home-manager, at least not in a straight forward way..
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
