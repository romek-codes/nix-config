{
  extraSystemConfig,
  inputs,
  system,
  pkgs,
  ...
}:
with inputs; let
  inherit (nixpkgs.lib) nixosSystem;
  inherit (pkgs) lib;

  sharedModules = [
    ../system/configuration.nix
    extraSystemConfig
    inputs.sops-nix.nixosModules.sops
  ];
in {
  meshify-pc = nixosSystem {
    inherit lib pkgs system;
    specialArgs = {inherit inputs;};
    modules = [../system/machine/meshify-pc] ++ sharedModules;
  };

  lenovo-yoga = nixosSystem {
    inherit lib pkgs system;
    specialArgs = {inherit inputs;};
    modules = [../system/machine/lenovo-yoga] ++ sharedModules;
  };

  work = nixosSystem {
    inherit lib pkgs system;
    specialArgs = {inherit inputs;};
    modules = [../system/machine/work] ++ sharedModules;
  };

  # FIXME: zfs-kernel-2.2.3-6.8.9 is marked as broken
  #edp-lenovo-yoga = nixosSystem {
  #inherit lib pkgs system;
  #specialArgs = { inherit inputs; };
  #modules = lenovoModules ++ [
  ## edp modules
  #home-manager.nixosModules.home-manager
  #(import ./mod.nix {
  #inherit inputs system;
  #extraSpecialArgs = pkgs.xargs { hidpi = false; };
  #})
  ## iso image modules
  #"${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ## disable networking.wireless from the iso minimal conf as we use networkmanager
  #{ networking.wireless.enable = false; }
  ## vm user and password
  #{ users.users.gvolpe.initialPassword = "test"; }
  #];
  #};
}
