{ pkgs, ... }:

{
  # TODO: For some reason SUPER,V stopped working after adding as a service.
  xdg.configFile."copyq/copyq.conf".source = ./copyq.conf;
}
