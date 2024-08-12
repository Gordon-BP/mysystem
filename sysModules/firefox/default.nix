# Config for firefox web browser
{config, pkgs, inputs, ...} : 
let
  # Rycee firefox-addons packages
  firefox-addons = inputs.firefox-addons.packages.${pkgs.system};
in
{
  # Configure Firefox.
  programs.firefox = {
    enable = true;
    /* ---- POLICIES ---- */
    # Check about:policies#documentation for options.
    policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value= true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        OfferToSaveLogins = false;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "always"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
        SearchBar = "unified"; # alternative: "separate"
        };
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        extensions = with firefox-addons; [
            ublock-origin
            bitwarden
            darkreader
            vimium
          ];
      # Check about:config for options.
      settings = { 
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "browser.bookmarks.autoExportHTML" = { Value = true; Status = "locked"; };
          "extensions.pocket.enabled" = { Value = false; Status = "locked"; };
          "extensions.screenshots.disabled" = { Value = false; Status = "locked"; };
          "extensions.autoDisableScopes" = 0;
          "browser.topsites.contile.enabled" = { Value = false; Status = "locked"; };
          "browser.formfill.enable" = { Value = false; Status = "locked"; };
          "browser.search.suggest.enabled" = { Value = false; Status = "locked"; };
          "browser.search.suggest.enabled.private" = { Value = false; Status = "locked"; };
          "browser.urlbar.suggest.searches" = { Value = false; Status = "locked"; };
          "browser.urlbar.showSearchSuggestionsFirst" = { Value = false; Status = "locked"; };
          "browser.newtabpage.activity-stream.feeds.section.topstories" = { Value = false; Status = "locked"; };
          "browser.newtabpage.activity-stream.feeds.snippets" = { Value = false; Status = "locked"; };
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = { Value = false; Status = "locked"; };
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = { Value = false; Status = "locked"; };
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = { Value = false; Status = "locked"; };
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = { Value = false; Status = "locked"; };
          "browser.newtabpage.activity-stream.showSponsored" = { Value = false; Status = "locked"; };
          "browser.newtabpage.activity-stream.system.showSponsored" = { Value = false; Status = "locked"; };
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = { Value = false; Status = "locked"; };
        };
      };
    };
  };
}
