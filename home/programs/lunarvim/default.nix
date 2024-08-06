{ lib, pkgs, ... }:

let
  lvimConf = lib.readFile ./config.lua;
in
{
  imports = [ ../../modules/lunarvim.nix ]; 

  programs.lunarvim = {
    enable = true;
    extraConfig = lvimConf;
  };
}
