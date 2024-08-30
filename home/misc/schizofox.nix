{theme, ...}: {
  programs.schizofox = {
    enable = false;
    security = {
      wrapWithProxychains = false;
      sanitizeOnShutdown = false;
      sandbox = true;
      userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
    };
    misc = {
      drm.enable = true;
      disableWebgl = false;
    };
    theme = {
      colors = with theme.colors; {
        background-darker = mantle;
        background = base;
        foreground = text;
        primary = accent;
      };
      font = "Lexend";
    };
    extensions = {
      simplefox.enable = true;
      darkreader.enable = true;
    };
    settings = {
      # fixes clipboard issues
      "dom.event.clipboardevents.enabled" = true;
    };
    search = rec {
      defaultSearchEngine = "Searx";
      # removeEngines = ["Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia" "LibRedirect" "DuckDuckGo"];
      searxUrl = "https://search.notashelf.dev";
      searxQuery = "${searxUrl}/search?q={searchTerms}&categories=general";
      # addEngines = [
      #   {
      #     Name = "Searxng";
      #     Description = "Decentralized search engine";
      #     Alias = "sx";
      #     Method = "GET";
      #     URLTemplate = "${searxQuery}";
      #   }
      # ];
    };
  };
}