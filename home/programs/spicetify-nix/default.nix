{ pkgs, inputs, lib, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  # fullAppDisplayMod and lyricsPlus forked to not show emote when lyrics not found.
  programs.spicetify = {
    enable = true;
    # text, dribbblish, orchis 
    theme = spicePkgs.themes.text;
    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
      adblock
      # fullAppDisplayMod
      ({
        src = "${pkgs.fetchFromGitHub {
          owner = "romek-codes";
          repo = "huh-spicetify-extensions";
          rev = "4089684621f15b458102decc600b855903df2cab";
          hash = "sha256-gtwhb8HYN/Xgv2DrYJ7JZYdE+v7L0x4DgvhIYeQLirE=";
        }}/fullAppDisplayModified";
        name = "fullAppDisplayMod.js";
        })
    ];
    enabledCustomApps = with spicePkgs.apps; [
      # lyricsPlus
      ({
        src = "${pkgs.fetchFromGitHub {
          owner = "romek-codes";
          repo = "cli";
          rev = "5915709702ca8ff17dbaa363c54081409f352c01";
          hash = "sha256-QLdmTC3L0KENja8y18qLLL1iJOWa9+U9zMAYbBwRBoA=";
        }}/CustomApps/lyrics-plus";
        name = "lyrics-plus";
        })
    ];
  };
}
