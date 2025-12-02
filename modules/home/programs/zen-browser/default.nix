{inputs, ...}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      ExtensionUpdate = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://mozilla.cloudflare-dns.com/dns-query";
        Fallback = false;
        Locked = true;
      };
      HardwareAcceleration = true;
      SearchEngines = {
        Default = "DuckDuckGo";
        PreventInstalls = true;
        Remove = ["Google" "Bing" "Perplexity"];
      };
      SearchSuggestEnabled = true;
      ExtensionSettings = {
        "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi" = {
          installation_mode = "force_installed";
        };
        "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi" = {
          installation_mode = "force_installed";
        };
        "https://addons.mozilla.org/firefox/downloads/file/3403419/export_cookies_txt-0.3.2.xpi" = {
          installation_mode = "force_installed";
        };
        "https://addons.mozilla.org/firefox/downloads/latest/noscript/latest.xpi" = {
          installation_mode = "force_installed";
        };
        "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi" = {
          installation_mode = "force_installed";
        };
        "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi" = {
          installation_mode = "force_installed";
        };
        "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi" = {
          installation_mode = "force_installed";
        };
        "https://addons.mozilla.org/firefox/downloads/latest/vue-js-devtools/latest.xpi" = {
          installation_mode = "force_installed";
        };
        "https://addons.mozilla.org/firefox/downloads/latest/wappalyzer/latest.xpi" = {
          installation_mode = "force_installed";
        };
      };
    };
    profiles."default" = {
      id = 0;
      isDefault = true;
    };
  };
}
