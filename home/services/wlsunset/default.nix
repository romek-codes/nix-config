{ pkgs, ... }:

{
  # screen color temp manager (like f.lux)
  services.wlsunset = {
    enable = true;
    sunrise = "06:30";
    sunset = "21:30";
  };
}
