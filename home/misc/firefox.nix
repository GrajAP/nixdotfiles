{...}: let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in {
  programs = {
    firefox = {
      enable = true;
      languagePacks = ["pl" "en-US"];
      profiles.default = {
        extensions.force = true;
        search = {
          force = true;
          default = "Startpage";
          engines = {
            "Startpage" = {
              urls = [{template = "https://www.startpage.com/rvd/search?query={searchTerms}&language=auto";}];
              icon = "https://www.startpage.com/sp/cdn/favicons/mobile/android-icon-192x192.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@s"];
            };
          };
        };
      };

      /*
      ---- POLICIES ----
      */
      # Check about:policies#documentation for options.
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "never"; # alternatives: "always", "never" or "default-on"
        SearchBar = "unified"; # alternative: "separate"
        SearchEngines = {
          Default = "Startpage";
          PreventInstalls = true;
          Remove = "Google";
        };

        SearchSuggestEnabled = true;

        /*
        ---- EXTENSIONS ----
        */
        # Check about:support for extension/add-on ID strings.
        # Valid strings for installation_mode are "allowed", "blocked",
        # "force_installed" and "normal_installed".
        ExtensionSettings = {
          "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
          # uBlock Origin:
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
            installation_mode = "force_installed";
          };
          "{d090b7ee-a385-4d54-b9a4-f7164d17756d}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-mocha-mauve/latest.xpi";
            installation_mode = "force_installed";
          };
          # "7a7a4a92-a2a0-41d1-9fd7-1e92480d612d" = {
          #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/stylus/latest.xpi";
          #   installation_mode = "force_installed";
          # };
        };

        /*
        ---- PREFERENCES ----
        */
        # Check about:config for options.
        Preferences = {
          "browser.contentblocking.category" = {
            Value = "strict";
            Status = "locked";
          };
          "extensions.pocket.enabled" = lock-false;
          "extensions.screenshots.disabled" = lock-true;
          "browser.topsites.contile.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          "browser.urlbar.suggest.searches" = lock-false;
          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
        };
      };
    };
  };
  stylix.targets.firefox = {
    profileNames = ["default"];
    #colorTheme.enable = true;
    #firefoxGnomeTheme.enable = true;
  };
}
