{
  pkgs,
  lib,
  inputs,
  ...
}: {
  environment = {
    # set channels (backwards compatibility)
    sessionVariables.FLAKE = "/etc/nixos";
    sessionVariables.NH_FLAKE = "/etc/nixos";
    etc = {
      "nix/flake-channels/nixpkgs".source = inputs.nixpkgs;
      "nix/flake-channels/home-manager".source = inputs.home-manager;
    };

    systemPackages = with pkgs; [
      nh
      nixd
      deadnix
      alejandra
      nvd
      statix
      glib
      libglibutil
      nix-output-monitor
    ];
    defaultPackages = [];
  };

  nixpkgs = {
    config = {
      # Wolność kocham i rozumiem
      # Wolności oddać nie umiem
      # <3333
      allowUnfree = true;
      allowUnsupportedSystem = true;
      allowBroken = true;

      overlays = [
        # workaround for: https://github.com/NixOS/nixpkgs/issues/154163
        (_: super: {
          hardware.pulseaudio.package = super.pulseaudioFull;
          sof-firmware = super.sof-firmware;
          coreutils = super.uutils-coreutils-noprefix;
          coreutils-full = super.uutils-coreutils-noprefix;
          makeModulesClosure = x:
            super.makeModulesClosure (x // {allowMissing = true;});
        })
      ];
    };
  };

  # faster rebuilding
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  nix = {
    gc.automatic = false;
    package = pkgs.lix;

    # Make builds run with low priority so my system stays responsive
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";

    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: {flake = v;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    #nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      experimental-features = nix-command flakes recursive-nix repl-flake
      keep-outputs = true
      warn-dirty = false
      keep-derivations = true
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
    settings = {
      flake-registry = "/etc/nix/registry.json";
      auto-optimise-store = true;
      # use binary cache, its not gentoo
      builders-use-substitutes = true;
      # allow sudo users to mark the following values as trusted
      allowed-users = ["@wheel"];
      trusted-users = ["@wheel"];
      sandbox = true;
      max-jobs = "auto";
      # continue building derivations if one fails
      keep-going = true;
      log-lines = 40;
      extra-experimental-features = ["flakes" "repl-flake" "nix-command" "recursive-nix" "ca-derivations"];

      # use binary cache, its not gentoo
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
      ];
    };
  };
  system = {
    switch = {
      enable = false;
      enableNg = true;
    };
    autoUpgrade = {
      enable = false;
      flake = inputs.self.outPath;
      flags = [
        "nixpkgs"
        "-L"
      ];
      dates = "09:00";
      randomizedDelaySec = "45min";
    };
    stateVersion = "24.11"; # DONT TOUCH THIS
  };
}
