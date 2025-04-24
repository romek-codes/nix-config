{
  pkgs,
  inputs,
  lib,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  # fullAppDisplayMod and lyricsPlus forked to not show emote when lyrics not found.
  programs.spicetify = {
    enable = true;
    # text, dribbblish, orchis
    # theme = spicePkgs.themes.text;
    theme = {
      src = "${pkgs.fetchFromGitHub {
        owner = "romek-codes";
        repo = "spicetify-themes";
        rev = "efccd548365976fc51e71846e79f0442e9c9b372";
        hash = "sha256-4EpvG+Q1HOS41mIB3kKrVw+MzvhASziebfb/WtsUPPc=";
      }}/text";
      name = "text";
      patches = {
        "xpui.js_find_8008" = ",(\\w+=)56";
        "xpui.js_repl_8008" = ",\${1}32";
      };
    };
    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
      adblock
      # fullAppDisplayMod
      {
        src = "${pkgs.fetchFromGitHub {
          owner = "romek-codes";
          repo = "huh-spicetify-extensions";
          rev = "4089684621f15b458102decc600b855903df2cab";
          hash = "sha256-gtwhb8HYN/Xgv2DrYJ7JZYdE+v7L0x4DgvhIYeQLirE=";
        }}/fullAppDisplayModified";
        name = "fullAppDisplayMod.js";
      }
    ];
    enabledCustomApps = with spicePkgs.apps; [
      # lyricsPlus
      {
        src = "${pkgs.fetchFromGitHub {
          owner = "romek-codes";
          repo = "cli";
          rev = "5915709702ca8ff17dbaa363c54081409f352c01";
          hash = "sha256-QLdmTC3L0KENja8y18qLLL1iJOWa9+U9zMAYbBwRBoA=";
        }}/CustomApps/lyrics-plus";
        name = "lyrics-plus";
      }
    ];
  };
}
