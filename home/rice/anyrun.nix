{config, ...}: let
  accent = config.lib.stylix.colors.base0D;
in {
  programs.anyrun = {
    enable = true;
    config = {
      x = {fraction = 0.5;};
      y = {fraction = 0.2;};
      width = {fraction = 0.3;};
      hideIcons = true;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = true;
      maxEntries = 5;
      plugins = [
        "libapplications.so"
        "libshell.so"
        "libstdin.so"
        "librink.so"
        "libwebsearch.so"
      ];
    };

    extraCss = ''
      window {
        background: transparent; /* rgba(0, 0, 0, 0.8);*/
      }

      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }

      #match.activatable {
        padding: 12px 14px;
        border-radius: 12px;

        color: white;
        margin-top: 4px;
        border: 2px solid transparent;
        transition: all 0.3s ease;
      }

      #match.activatable:not(:first-child) {
        border-top-left-radius: 0;
        border-top-right-radius: 0;
        border-top: 2px solid rgba(255, 255, 255, 0.1);
      }

      #match.activatable #match-title {
        font-size: 1.2rem;
      }

      #match.activatable:hover {
        border: 2px solid rgba(255, 255, 255, 0.4);
      }

      #match-title, #match-desc {
        color: inherit;
      }

      #match.activatable:hover, #match.activatable:selected {
        border-top-left-radius: 12px;
        border-top-right-radius: 12px;
      }

      #match.activatable:selected + #match.activatable, #match.activatable:hover + #match.activatable {
        border-top: 2px solid transparent;
      }

      #match.activatable:selected, #match.activatable:hover:selected {
        background: rgba(255,255,255,0.1);
        border: 2px solid #${accent};
        border-top: 2px solid #${accent};
      }

      #match, #plugin {
        box-shadow: none;
      }

      #entry {
        color: white;
        box-shadow: none;
        border-radius: 12px;
        border: 2px solid #${accent};
      }

      box#main {
        background: rgba(36, 39, 58, 0.7);
        border-radius: 16px;
        padding: 8px;
        box-shadow: 0px 2px 33px -5px rgba(0, 0, 0, 0.5);
      }

      row:first-child {
        margin-top: 6px;
      }

    '';
    extraConfigFiles."websearch.ron".text = ''

      Config(
        prefix: "?",
        engines: [
          Custom(
            name: "StartPage",
            url: "www.startpage.com/do/dsearch?query={}",
          ),
          Custom(
            name: "YouTube",
            url: "www.youtube.com/results?search_query={}",
          ),
          Custom(
            name: "nix packages",
            url: "search.nixos.org/packages?query={}&channel=unstable",
          ),

        ],
      )
    '';
  };
}
