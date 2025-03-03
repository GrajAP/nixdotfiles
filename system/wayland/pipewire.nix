{...}: {
  hardware.enableAllFirmware = true;
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
    pulseaudio.support32Bit = true;
  };
}
