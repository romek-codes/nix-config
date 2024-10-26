{ extraPkgs, inputs, system, pkgs, ... }:

with inputs;

let
  sharedImports = [
    inputs.spicetify-nix.homeManagerModules.default
    inputs.textfox.homeManagerModules.default
    ({ home.packages = extraPkgs; })
  ];

  hyprlandDpiSettings = { hidpi }: {
    programs.browser.settings.dpi = if hidpi then "0" else "1";
  };

  mkHyprlandHome = { hidpi }:
    let
      imports = sharedImports ++ [
        inputs.hypr-binds-flake.homeManagerModules.${system}.default
        ../home/wm/hyprland/home.nix
        (hyprlandDpiSettings { inherit hidpi; })
      ];
    in
    (
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = (pkgs.xargs { inherit hidpi; }) // { inherit inputs; };
        modules = [{ inherit imports; }];
      }
    );
in
{
  hyprland-edp = mkHyprlandHome { hidpi = false; };
  hyprland-hdmi = mkHyprlandHome { hidpi = true; };
}
