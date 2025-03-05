{...}: {
  services = {
    ollama = {
      enable = true;
      #acceleration = "rocm";
      environmentVariables = {
        HCC_AMDGPU_TARGET = "gfx803"; # used to be necessary, but doesn't seem to anymore
      };
      rocmOverrideGfx = "8.0.3";
    };

    kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          devices = [
            "/dev/input/by-path/pci-0000:0e:00.3-usb-0:1:1.0-event-kbd"
            #"/dev/input/by-path/pci-0000:0e:00.3-usb-0:2:1.1-event-kbd"
            #"/dev/input/by-path/pci-0000:0e:00.3-usb-0:1:1.2-event-kbd"
          ];
          extraDefCfg = "process-unmapped-keys yes";
          config = ''

            (defsrc
              caps a s d f j k l ;
            )
            (defvar
              tap-time 200
              hold-time 200
            )

            (defalias
              escctrl (tap-hold $tap-time $hold-time esc lctl)
              a (multi f24 (tap-hold $tap-time $hold-time a lmet))
              s (multi f24 (tap-hold $tap-time $hold-time s ralt))
              d (multi f24 (tap-hold $tap-time $hold-time d lsft))
              f (multi f24 (tap-hold $tap-time $hold-time f lctl))
              j (multi f24 (tap-hold $tap-time $hold-time j lctl))
              k (multi f24 (tap-hold $tap-time $hold-time k lsft))
              l (multi f24 (tap-hold $tap-time $hold-time l ralt))
              ; (multi f24 (tap-hold $tap-time $hold-time ; lmet))
            )

            (deflayer base
              @escctrl @a @s @d @f @j @k @l @;
            )


          '';
        };
      };
    };
  };
}
