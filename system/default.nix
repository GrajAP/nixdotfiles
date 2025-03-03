{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vesktop
    (discord.override {
      withOpenASAR = false;
      withVencord = true;
    })
  ];
  imports = [
    ./wayland
    ./core
  ];
}
