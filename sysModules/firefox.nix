{config, pkgs, inputs, ...} : 
let
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

        /* ---- EXTENSIONS ---- */
        # Check about:support for extension/add-on ID strings.
        # Valid strings for installation_mode are "allowed", "blocked",
        # "force_installed" and "normal_installed".
        ExtensionSettings = {
          "*".installation_mode = "allowed"; # blocks all addons except the ones specified below
          # uBlock Origin:
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          # Dark Reader:
          "addon@darkreader.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader-4.9.88.xpi";
            installation_mode = "force_installed";
          };
          # Bitwarden:
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden_password_manager-2024.7.1.xpi";
            installation_mode = "force_installed";
          };
        };
  
        /* ---- PREFERENCES ---- */
        # Check about:config for options.
        Preferences = { 
          "gfx.webrender.all" = { Value = false; Status = "locked"; };
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "browser.bookmarks.autoExportHTML" = { Value = true; Status = "locked"; };
          "extensions.pocket.enabled" = { Value = false; Status = "locked"; };
          "extensions.screenshots.disabled" = { Value = false; Status = "locked"; };
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
          "browser.startup.homepage" = { Value = "file:///home/gordy/.config/startup.html"; Status = "locked"; };
        };
        wrapperConfig = {
          pipewireSupport = true;
          };
      };
    };
}
