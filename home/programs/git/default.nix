{pkgs, isWork, ...}: let
  gitConfig = {
    core = {
      editor = "nvim";
      pager = "diff-so-fancy | less --tabs=4 -RFX";
    };
    init.defaultBranch = "main";
    merge = {
      conflictStyle = "diff3";
      tool = "vim_mergetool";
    };
    mergetool."vim_mergetool" = {
      #cmd = "nvim -d -c \"wincmd l\" -c \"norm ]c\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\"";
      # this command requires the vim-mergetool plugin
      cmd = "nvim -f -c \"MergetoolStart\" \"$MERGED\" \"$BASE\" \"$LOCAL\" \"$REMOTE\"";
      prompt = false;
    };
    pull.rebase = false;
    push.autoSetupRemote = true;
    url = {
      "https://github.com/".insteadOf = "gh:";
      "ssh://git@github.com".pushInsteadOf = "gh:";
      "https://gitlab.com/".insteadOf = "gl:";
      "ssh://git@gitlab.com".pushInsteadOf = "gl:";
    };
  };

  rg = "${pkgs.ripgrep}/bin/rg";
in {
  home.packages = with pkgs.gitAndTools; [
    diff-so-fancy # git diff with colors
    git-crypt # git files encryption
    hub # github command-line client
    tig # diff and commit view
  ];

  programs.git =
    {
      enable = true;
      aliases = {
        amend = "commit --amend -m";
        fixup = "!f(){ git reset --soft HEAD~\${1} && git commit --amend -C HEAD; };f";
        loc = "!f(){ git ls-files | ${rg} \"\\.\${1}\" | xargs wc -l; };f"; # lines of code
        br = "branch";
        co = "checkout";
        cob = "checkout -b";
        st = "status";
        ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
        ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
        cm = "commit -m";
        ca = "commit -am";
        dc = "diff --cached";
        rmain = "rebase main";
        rc = "rebase --continue";
      };
      extraConfig = gitConfig;
      ignores = [
        "*.bloop"
        "*.bsp"
        "*.metals"
        "*.metals.sbt"
        "*metals.sbt"
        "*.direnv"
        "*.envrc" # there is lorri, nix-direnv & simple direnv; let people decide
        "*hie.yaml" # ghcide files
        "*.mill-version" # used by metals
        "*.jvmopts" # should be local to every project
      ];
      signing = {
        key =
          if isWork
          then "86FB80FCC9361C0C"
          else "7AE6055A1268DAD6";
        signByDefault = true;
      };

      userEmail =
        if isWork
        then "roman.juszczyk@zoxs.de"
        else "contact@romek.codes";
      userName =
        if isWork
        then "Roman Juszczyk"
        else "romek";
    }
    // (pkgs.sxm.git or {});
}
