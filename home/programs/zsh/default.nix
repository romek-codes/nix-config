{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    zsh
    oh-my-zsh
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "laravel" "tmux" ];
    };

    plugins = [
      {                                                                                   
        name = "powerlevel10k";                                                           
        src = pkgs.zsh-powerlevel10k;                                                     
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";                         
      }
    ];

    shellAliases = {
      sail = "[ -f sail ] && sh sail || sh vendor/bin/sail";
      phpstan = "./vendor/bin/phpstan";
      pint = "./vendor/bin/pint";
      explorer = "explorer.exe .";
      open = "xdg-open";
      v = "lvim .";
      lv = "lvim .";
      duh = "du -ha -d 1 | sort -hr";
    };


    initExtraFirst = ''
      if [[ -r "$${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$${(%):-%n}.zsh" ]]; then
        source "$${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$${(%):-%n}.zsh"
      fi

      ZSH_TMUX_AUTOSTART=true
    '';

    initExtra = ''
      eval $(thefuck --alias)

      # API KEYS
      export GROQ_API_KEY=

      # PATH STUFF
      export PATH="$HOME/.nvm/versions/node/:$HOME/.config/composer/vendor/bin:$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/bin:$HOME/.local/bin:/mnt/c/Windows/System32:/mnt/c/Windows/SysWOW64:/opt/nvim-linux64/bin:$PATH:$HOME/.npm-global/bin:$PATH"

      # NVM setup
      export NVM_DIR="$([ -z "''${XDG_CONFIG_HOME-}" ] && printf %s "$HOME/.nvm" || printf %s "''${XDG_CONFIG_HOME}/nvm")"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

      # Enable auto-cd
      setopt auto_cd

      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };


  # Create an empty .zshrc to prevent the newuser setup
  home.file.".zshrc".text = "# This file is managed by Home Manager";
}
