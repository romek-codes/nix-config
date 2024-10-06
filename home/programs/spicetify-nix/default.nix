{ pkgs, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  programs.spicetify = {
    enable = true;
    # text, dribbblish, orchis 
    theme = spicePkgs.themes.text;
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
