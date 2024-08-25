{ config, pkgs,  ... }:
{
  hardware = {
    pulseaudio.support32Bit = true;
    enableAllFirmware = true;
  };
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

}
