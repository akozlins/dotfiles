
read_prefs(prefs, FIREFOX_HOME + "/ghacks-user.js/user.js");

user_pref("browser.startup.page", null);
user_pref("layout.css.visited_links_enabled", null);
user_pref("browser.formfill.enable", null);
user_pref("signon.autofillForms", null);
user_pref("browser.sessionstore.privacy_level", 1); // do not store extra session data on unencrypted sites
user_pref("security.OCSP.require", null);
user_pref("browser.display.use_document_fonts", null);
user_pref("network.http.referer.XOriginPolicy", null);
user_pref("media.gmp-widevinecdm.visible", null); // Content Decryption Module
user_pref("media.gmp-widevinecdm.enabled", null);
user_pref("media.eme.enabled", null); // Encryption Media Extension
user_pref("media.peerconnection.enabled", null);
user_pref("webgl.disabled", null);
user_pref("dom.serviceWorkers.enabled", null);
user_pref("javascript.options.asmjs", null);
user_pref("dom.webaudio.enabled", null);
user_pref("pdfjs.disabled", null);
user_pref("browser.download.useDownloadDir", null);
user_pref("security.csp.enable", null);
user_pref("network.cookie.cookieBehavior", null); // Accept cookies and site data
user_pref("privacy.sanitize.sanitizeOnShutdown", null);
user_pref("privacy.firstparty.isolate", null);
user_pref("privacy.resistFingerprinting", null);
user_pref("privacy.resistFingerprinting.letterboxing", null);
