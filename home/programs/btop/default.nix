{pkgs, ...}:
# command-line system information
{
  xdg.configFile."btop/btop.conf".source = ./btop.conf;
}
