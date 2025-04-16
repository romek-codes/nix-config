{pkgs, ...}: {
  # Fetch PhotoGIMP configuration files from GitHub and install to ~/.config/GIMP/2.10/
  xdg.configFile."GIMP/2.10" = {
    source =
      pkgs.fetchFromGitHub {
        owner = "Diolinux";
        repo = "PhotoGIMP";
        rev = "master";
        sha256 = "sha256-tWbkHf0Es/I0oLooep+GIFhFXWgGxanBUUCpzHMzC1I=";
      }
      + "/.var/app/org.gimp.GIMP/config/GIMP/2.10";
  };
}
