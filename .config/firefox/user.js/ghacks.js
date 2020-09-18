
eval_file(FIREFOX_HOME + "/ghacks-user.js/user.js");

del_pref("browser.startup.page");
del_pref("layout.css.visited_links_enabled");
del_pref("browser.formfill.enable");
del_pref("signon.autofillForms");
user_pref("browser.sessionstore.privacy_level", 1); // do not store extra session data on unencrypted sites
del_pref("security.OCSP.require");
del_pref("browser.display.use_document_fonts");
del_pref("network.http.referer.XOriginPolicy");
del_pref("media.gmp-widevinecdm.visible"); // Content Decryption Module
del_pref("media.gmp-widevinecdm.enabled");
del_pref("media.eme.enabled"); // Encryption Media Extension
del_pref("media.peerconnection.enabled");
del_pref("webgl.disabled");
del_pref("dom.serviceWorkers.enabled");
del_pref("javascript.options.asmjs");
del_pref("javascript.options.wasm");
del_pref("dom.webaudio.enabled");
del_pref("pdfjs.disabled");
del_pref("browser.download.useDownloadDir");
del_pref("security.csp.enable");
del_pref("network.cookie.cookieBehavior"); // Accept cookies and site data
del_pref("privacy.sanitize.sanitizeOnShutdown");
del_pref("privacy.firstparty.isolate");
del_pref("privacy.resistFingerprinting");
del_pref("privacy.resistFingerprinting.letterboxing");
