{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
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
