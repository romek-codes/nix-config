let
  more = { pkgs, ... }: {
    programs = {
      bat.enable = true;

      broot = {
        enable = true;
        enableFishIntegration = false;
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      fzf = {
        enable = true;
        enableFishIntegration = false; # broken
        defaultCommand = "fd --type file --follow"; # FZF_DEFAULT_COMMAND
        defaultOptions = [ "--height 20%" ]; # FZF_DEFAULT_OPTS
        fileWidgetCommand = "fd --type file --follow"; # FZF_CTRL_T_COMMAND
      };

      gpg.enable = true;

      htop = {
        enable = true;
        settings = {
          sort_direction = true;
          sort_key = "PERCENT_CPU";
        };
      };

      jq.enable = true;

      obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          obs-backgroundremoval
          obs-pipewire-audio-capture
          obs-composite-blur
          obs-vkcapture
        ];
        # plugins = [
          # (pkgs.wrapOBS {
          #   plugins = with pkgs.obs-studio-plugins; [
          #     obs-backgroundremoval
          #     obs-pipewire-audio-capture
          #     obs-composite-blur
          #   ];
          # })
        # ];
      };

      ssh.enable = true;

      zoxide = {
        enable = true;
        options = [ ];
      };

    };
  };
in
[
  ../programs/dconf
  ../programs/git
  ../programs/firefox
  ../programs/zsh
  ../programs/khal
  ../programs/md-toc
  ../programs/mimeo
  ../programs/mpv
  ../programs/neofetch
  ../programs/lunarvim
  ../programs/ngrok
  ../programs/signal
  ../programs/yubikey
  ../programs/zathura
  ../programs/tmux
  # ../programs/spotify
  # ../programs/spicetify-nix
  more
]
