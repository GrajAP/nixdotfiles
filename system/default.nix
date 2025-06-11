{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vesktop
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
  ];
  imports = [
    ./wayland
    ./core
  ];
}
