{
  config,
  pkgs,
  ...
}: {
  programs.zsh.enable = true;
  programs.adb.enable = true;
  services.openssh = {
    enable = true;
    openFirewall = true;
      };
  users = {
    mutableUsers = false;
    users = {
      grajap = {
        isNormalUser = true;
        initialPassword = "haselko123";
        extraGroups = [
          "wheel"
          "gitea"
          "docker"
          "systemd-journal"
          "vboxusers"
          "audio"
          "plugdev"
          "wireshark"
          "video"
          "input"
          "lp"
          "networkmanager"
          "power"
          "nix"
          "adbusers"
        ];
        uid = 1000;
        shell =
          if config.services.greetd.enable
          then pkgs.zsh
          else pkgs.bash;
        
      };
      };
  };
}
