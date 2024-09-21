{ pkgs, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  programs.spicetify = {
    enable = true;
    # text, dribbblish
    theme = spicePkgs.themes.orchis;
    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
      adblock
      fullAppDisplayMod
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
    ];
  };
}
