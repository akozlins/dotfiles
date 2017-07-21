
user_pref("general.smoothScroll", false);
user_pref("general.warnOnAboutConfig", false);

user_pref("browser.download.dir", "/home/akozlins/downloads");
user_pref("browser.download.lastDir", "/home/akozlins/downloads");
user_pref("browser.open.lastDir", "/home/akozlins/downloads");
user_pref("browser.ctrlTab.previews", true);

user_pref("browser.fullscreen.animate", false);

user_pref("browser.tabs.animate", false);
user_pref("browser.tabs.closeWindowWithLastTab", false);
user_pref("browser.tabs.tabMaxWidth", 120);
user_pref("browser.tabs.tabMinWidth", 120);
user_pref("browser.tabs.warnOnClose", false);

user_pref("browser.search.defaultenginename", "DuckDuckGo");
user_pref("browser.search.hiddenOneOffs", "Yahoo,Bing,Amazon.com,eBay,Twitter");

//user_pref("font.name.monospace.x-western", "Courier New");
//user_pref("font.name.sans-serif.x-western", "Arial");
//user_pref("font.name.serif.x-western", "Times New Roman");

user_pref("pdfjs.defaultZoomValue", "page-width");

user_pref("print.print_resolution", 600);
user_pref("print.print_paper_name", "iso_a4");
user_pref("print.print_orientation", 0);

user_pref("extensions.cleanlinks.enabled", false);

user_pref("extensions.classicthemerestorer.aboutprefs", "category-security");
user_pref("extensions.classicthemerestorer.aboutprefsInd", 3);
user_pref("extensions.classicthemerestorer.bfurlbarfix", true);
user_pref("extensions.classicthemerestorer.bmanimation", false);
user_pref("extensions.classicthemerestorer.ctrreset", false);
user_pref("extensions.classicthemerestorer.fsaduration", false);
user_pref("extensions.classicthemerestorer.pananimation", false);
user_pref("extensions.classicthemerestorer.pref_actindx", 4);
user_pref("extensions.classicthemerestorer.smallnavbut", true);
user_pref("extensions.classicthemerestorer.tabsontop", "true");

user_pref("extensions.firegestures.keypressgesture", false);
user_pref("extensions.firegestures.mousetrail", false);
user_pref("extensions.firegestures.rockergesture", true);
user_pref("extensions.firegestures.status_display", 0);
user_pref("extensions.firegestures.swipegesture", false);
user_pref("extensions.firegestures.wheelgesture", false);

user_pref("extensions.greasemonkey.enabled", true);

user_pref("extensions.tabmix.appearance.selectedTabIndex", 1);
user_pref("extensions.tabmix.events.selectedTabIndex", 3);
user_pref("extensions.tabmix.lasttab.tabPreviews", false);
user_pref("extensions.tabmix.sessions.crashRecovery", false);
user_pref("extensions.tabmix.sessions.crashed", true);
user_pref("extensions.tabmix.sessions.manager", false);
user_pref("extensions.tabmix.tabBarMode", 2);
user_pref("extensions.tabmix.unloadedTab", false);
user_pref("extensions.tabmix.unreadTab", false);

/******************************************************************************
 * https://github.com/pyllyukko/user.js                                       *
 ******************************************************************************/

/******************************************************************************
 * SECTION: HTML5 / APIs / DOM                                                *
 ******************************************************************************/

// PREF: Disable Service Workers
// NOTICE: Disabling ServiceWorkers breaks functionality on some sites (Google Street View ...)
// Unknown security implications
//user_pref("dom.serviceWorkers.enabled", false);

// PREF: Disable Web Workers
//user_pref("dom.workers.enabled", false);

// PREF: Disable web notifications
//user_pref("dom.webnotifications.enabled", false);

// PREF: Disable DOM timing API
user_pref("dom.enable_performance", false);

// PREF: Make sure the User Timing API does not provide a new high resolution timestamp
user_pref("dom.enable_user_timing", false);

// PREF: Disable Web Audio API
user_pref("dom.webaudio.enabled", false);

// PREF: Disable Location-Aware Browsing (geolocation)
user_pref("geo.enabled", false);

// PREF: When geolocation is enabled, use Mozilla geolocation service instead of Google
user_pref("geo.wifi.uri", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");

// PREF: When geolocation is enabled, don't log geolocation requests to the console
user_pref("geo.wifi.logging.enabled", false);

// PREF: Disable raw TCP socket support (mozTCPSocket)
//user_pref("dom.mozTCPSocket.enabled", false);

// PREF: Disable DOM storage (disabled)
// NOTICE-DISABLED: Disabling DOM storage is known to cause`TypeError: localStorage is null` errors
//user_pref("dom.storage.enabled", false);

// PREF: Disable leaking network/browser connection information via Javascript
user_pref("dom.netinfo.enabled", false);

// PREF: Disable WebRTC entirely to prevent leaking internal IP addresses (Firefox < 42)
// NOTICE: Disabling WebRTC breaks peer-to-peer file sharing tools (reep.io ...)
//user_pref("media.peerconnection.enabled", false);

// PREF: Don't reveal your internal IP when WebRTC is enabled (Firefox >= 42)
user_pref("media.peerconnection.ice.default_address_only", true); // Firefox 42-51
user_pref("media.peerconnection.ice.no_host", true); // Firefox >= 52

// PREF: Disable WebRTC getUserMedia, screen sharing, audio capture, video capture
user_pref("media.navigator.enabled", false);
user_pref("media.navigator.video.enabled", false);
user_pref("media.getusermedia.screensharing.enabled", false);
user_pref("media.getusermedia.audiocapture.enabled", false);

// PREF: Disable battery API (Firefox < 52)
user_pref("dom.battery.enabled", false);

// PREF: Disable telephony API
user_pref("dom.telephony.enabled", false);

// PREF: Disable "beacon" asynchronous HTTP transfers (used for analytics)
user_pref("beacon.enabled", false);

// PREF: Disable clipboard event detection (onCut/onCopy/onPaste) via Javascript
user_pref("dom.event.clipboardevents.enabled", false);

// PREF: Disable "copy to clipboard" functionality via Javascript (Firefox >= 41)
// NOTICE: Disabling clipboard operations will break legitimate JS-based "copy to clipboard" functionality
user_pref("dom.allow_cut_copy", false);

// PREF: Disable speech recognition
user_pref("media.webspeech.recognition.enable", false);

// PREF: Disable speech synthesis
user_pref("media.webspeech.synth.enabled", false);

// PREF: Disable sensor API
user_pref("device.sensors.enabled", false);

// PREF: Disable pinging URIs specified in HTML <a> ping= attributes
user_pref("browser.send_pings", false);

// PREF: When browser pings are enabled, only allow pinging the same host as the origin page
user_pref("browser.send_pings.require_same_host", true);

// PREF: Disable IndexedDB (disabled)
// NOTICE-DISABLED: IndexedDB could be used for tracking purposes, but is required for some add-ons to work (notably uBlock), so is left enabled
//user_pref("dom.indexedDB.enabled", false);

// TODO: "Access Your Location" "Maintain Offline Storage" "Show Notifications"

// PREF: Disable gamepad API to prevent USB device enumeration
user_pref("dom.gamepad.enabled", false);

// PREF: Disable virtual reality devices APIs
user_pref("dom.vr.enabled", false);

// PREF: Disable vibrator API
user_pref("dom.vibrator.enabled", false);

// PREF: Disable resource timing API
user_pref("dom.enable_resource_timing", false);

// PREF: Disable Archive API (Firefox < 54)
user_pref("dom.archivereader.enabled", false);

// PREF: Disable webGL
// https://en.wikipedia.org/wiki/WebGL
//user_pref("webgl.disabled", true);
// PREF: When webGL is enabled, use the minimum capability mode
user_pref("webgl.min_capability_mode", true);
// PREF: When webGL is enabled, disable webGL extensions
user_pref("webgl.disable-extensions", true);
// PREF: When webGL is enabled, force enabling it even when layer acceleration is not supported
user_pref("webgl.disable-fail-if-major-performance-caveat", true);
// PREF: When webGL is enabled, do not expose information about the graphics driver
user_pref("webgl.enable-debug-renderer-info", false);

/******************************************************************************
 * SECTION: Misc                                                              *
 ******************************************************************************/

// PREF: Disable face detection
user_pref("camera.control.face_detection.enabled", false);

// PREF: Set the default search engine to DuckDuckGo (disabled)
//user_pref("browser.search.defaultenginename", "DuckDuckGo");
//user_pref("browser.search.order.1", "DuckDuckGo");
//user_pref("keyword.URL", "https://duckduckgo.com/html/?q=!+");

// PREF: Disable GeoIP lookup on your address to set default search engine region
user_pref("browser.search.countryCode", "US");
user_pref("browser.search.region", "US");
user_pref("browser.search.geoip.url", "");

// PREF: Set Accept-Language HTTP header to en-US regardless of Firefox localization
user_pref("intl.accept_languages", "en-us, en");

// PREF: Set Firefox locale to en-US
user_pref("general.useragent.locale", "en-US");

// PREF: Don't use OS values to determine locale, force using Firefox locale setting
user_pref("intl.locale.matchOS", false);

// PREF: Don't use Mozilla-provided location-specific search engines
user_pref("browser.search.geoSpecificDefaults", false);

// PREF: Do not automatically send selection to clipboard on some Linux platforms
user_pref("clipboard.autocopy", false);

// PREF: Prevent leaking application locale/date format using JavaScript
user_pref("javascript.use_us_english_locale", true);

// PREF: Do not submit invalid URIs entered in the address bar to the default search engine
user_pref("keyword.enabled", false);

// PREF: Don't trim HTTP off of URLs in the address bar.
user_pref("browser.urlbar.trimURLs", false);

// PREF: Don't try to guess domain names when entering an invalid domain name in URL bar
user_pref("browser.fixup.alternate.enabled", false);

// PREF: When browser.fixup.alternate.enabled is enabled, strip password from 'user:password@...' URLs
//user_pref("browser.fixup.hide_user_pass", true);

// PREF: Send DNS request through SOCKS when SOCKS proxying is in use
user_pref("network.proxy.socks_remote_dns", true);

// PREF: Don't monitor OS online/offline connection state
user_pref("network.manage-offline-status", false);

// PREF: Enforce Mixed Active Content Blocking
//user_pref("security.mixed_content.block_active_content", true);

// PREF: Enforce Mixed Passive Content blocking (a.k.a. Mixed Display Content)
// NOTICE: Enabling Mixed Display Content blocking can prevent images/styles ... from loading properly when connection to the website is only partially secured
//user_pref("security.mixed_content.block_display_content", true);

// PREF: Disable JAR from opening Unsafe File Types
//user_pref("network.jar.open-unsafe-types", false);

// CIS 2.7.4 Disable Scripting of Plugins by JavaScript
//user_pref("security.xpconnect.plugin.unrestricted", false);

// PREF: Set File URI Origin Policy
//user_pref("security.fileuri.strict_origin_policy", true);

// PREF: Disable Displaying Javascript in History URLs
user_pref("browser.urlbar.filter.javascript", true);

// PREF: Disable asm.js
//user_pref("javascript.options.asmjs", false);

// PREF: Disable SVG in OpenType fonts
// https://wiki.mozilla.org/SVGOpenTypeFonts
//user_pref("gfx.font_rendering.opentype_svg.enabled", false);

// PREF: Disable in-content SVG rendering (Firefox >= 53)
// NOTICE: Disabling SVG support breaks many UI elements on many sites
//user_pref("svg.disabled", true);

// PREF: Disable video stats to reduce fingerprinting threat
user_pref("media.video_stats.enabled", false);

// PREF: Don't reveal build ID
// Value taken from Tor Browser
//user_pref("general.buildID.override", "20100101");

// PREF: Prevent font fingerprinting
user_pref("browser.display.use_document_fonts", 0);

// PREF: Enable only whitelisted URL protocol handlers
// NOTICE: Disabling nonessential protocols breaks all interaction with custom protocols such as mailto:, irc:, magnet: ... and breaks opening third-party mail/messaging/torrent/... clients when clicking on links with these protocols
//user_pref("network.protocol-handler.warn-external-default", true);

/******************************************************************************
 * SECTION: Extensions / plugins                                              *
 ******************************************************************************/

// PREF: Ensure you have a security delay when installing add-ons (milliseconds)
user_pref("security.dialog_enable_delay", 1000);

// PREF: Require signatures
//user_pref("xpinstall.signatures.required", true);

// PREF: Opt-out of add-on metadata updates
user_pref("extensions.getAddons.cache.enabled", false);

// PREF: Opt-out of themes (Persona) updates
user_pref("lightweightThemes.update.enabled", false);

// PREF: Disable Flash Player NPAPI plugin
//user_pref("plugin.state.flash", 0);

// PREF: Disable Java NPAPI plugin
//user_pref("plugin.state.java", 0);

// PREF: Disable sending Flash Player crash reports
user_pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled", false);

// PREF: When Flash crash reports are enabled, don't send the visited URL in the crash report
user_pref("dom.ipc.plugins.reportCrashURL", false);

// PREF: When Flash is enabled, download and use Mozilla SWF URIs blocklist
user_pref("browser.safebrowsing.blockedURIs.enabled", true);

// PREF: Disable Shumway (Mozilla Flash renderer)
//pref("shumway.disabled", true);

// PREF: Disable Gnome Shell Integration NPAPI plugin
user_pref("plugin.state.libgnome-shell-browser-plugin", 0);

// PREF: Disable the bundled OpenH264 video codec (disabled)
//user_pref("media.gmp-provider.enabled", false);

// PREF: Enable plugins click-to-play
//user_pref("plugins.click_to_play", true);

// PREF: Updates addons automatically
//user_pref("extensions.update.enabled", true);

// PREF: Enable add-on and certificate blocklists (OneCRL) from Mozilla
// Updated at interval defined in extensions.blocklist.interval (default: 86400)
user_pref("extensions.blocklist.enabled", true);
user_pref("services.blocklist.update_enabled", true);

// PREF: Decrease system information leakage to Mozilla blocklist update servers
//user_pref("extensions.blocklist.url", "https://blocklist.addons.mozilla.org/blocklist/3/%APP_ID%/%APP_VERSION%/");

/******************************************************************************
 * SECTION: Firefox (anti-)features / components                              *
 ******************************************************************************/

// PREF: Disable WebIDE
//user_pref("devtools.webide.enabled", false);
//user_pref("devtools.webide.autoinstallADBHelper", false);
//user_pref("devtools.webide.autoinstallFxdtAdapters", false);

// PREF: Disable remote debugging
user_pref("devtools.debugger.remote-enabled", false);
user_pref("devtools.chrome.enabled", false);
user_pref("devtools.debugger.force-local", true);

// PREF: Disable Mozilla telemetry/experiments
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("experiments.supported", false);
user_pref("experiments.enabled", false);
user_pref("experiments.manifest.uri", "");

// PREF: Disallow Necko to do A/B testing
user_pref("network.allow-experiments", false);

// PREF: Disable sending Firefox crash reports to Mozilla servers
// A list of submitted crash reports can be found at about:crashes
user_pref("breakpad.reportURL", "");

// PREF: Disable sending reports of tab crashes to Mozilla (about:tabcrashed), don't nag user about unsent crash reports
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);

// PREF: Disable FlyWeb (discovery of LAN/proximity IoT devices that expose a Web interface)
user_pref("dom.flyweb.enabled", false);

// PREF: Disable the UITour backend
user_pref("browser.uitour.enabled", false);

// PREF: Enable Firefox Tracking Protection
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.pbmode.enabled", true);

// PREF: Enable contextual identity Containers feature (Firefox >= 52)
// NOTICE: Containers are not available in Private Browsing mode
//user_pref("privacy.userContext.enabled", true);

// PREF: Enable hardening against various fingerprinting vectors (Tor Uplift project)
user_pref("privacy.resistFingerprinting", true);

// PREF: Disable the built-in PDF viewer
//user_pref("pdfjs.disabled", true);

// PREF: Disable collection/sending of the health report (healthreport.sqlite*)
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

// PREF: Disable Heartbeat (Mozilla user rating telemetry)
user_pref("browser.selfsupport.url", "");

// PREF: Disable Firefox Hello (disabled) (Firefox < 49)
// NOTICE-DISABLED: Firefox Hello requires setting `media.peerconnection.enabled` and `media.getusermedia.screensharing.enabled` to true, `security.OCSP.require` to false to work.
//user_pref("loop.enabled", false);

// PREF: Disable Firefox Hello metrics collection
user_pref("loop.logDomains", false);

// PREF: Enable Auto Update (disabled)
// NOTICE: Fully automatic updates are disabled and left to package management systems on Linux. Windows users may want to change this setting.
//user_pref("app.update.auto", true);

// PREF: Enforce checking for Firefox updates
// NOTICE: Update check page might incorrectly report Firefox ESR as out-of-date
//user_pref("app.update.enabled", true);

// PREF: Enable blocking reported web forgeries
user_pref("browser.safebrowsing.enabled", true); // Firefox < 50
user_pref("browser.safebrowsing.phishing.enabled", true); // firefox >= 50

// PREF: Enable blocking reported attack sites
user_pref("browser.safebrowsing.malware.enabled", true);

// PREF: Disable querying Google Application Reputation database for downloaded binary files
user_pref("browser.safebrowsing.downloads.remote.enabled", false);

// PREF: Disable Pocket
user_pref("browser.pocket.enabled", false);
user_pref("extensions.pocket.enabled", false);

/******************************************************************************
 * SECTION: Automatic connections                                             *
 ******************************************************************************/

// PREF: Disable prefetching of <link rel="next"> URLs
user_pref("network.prefetch-next", false);

// PREF: Disable DNS prefetching
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);

// PREF: Disable the predictive service (Necko)
user_pref("network.predictor.enabled", false);

// PREF: Reject .onion hostnames before passing the to DNS
user_pref("network.dns.blockDotOnion", true);

// PREF: Disable search suggestions in the search bar
user_pref("browser.search.suggest.enabled", false);

// PREF: Disable "Show search suggestions in location bar results"
//user_pref("browser.urlbar.suggest.searches", false);
// PREF: When using the location bar, don't suggest URLs from browsing history
//user_pref("browser.urlbar.suggest.history", false);

// PREF: Disable SSDP
user_pref("browser.casting.enabled", false);

// PREF: Disable automatic downloading of OpenH264 codec
//user_pref("media.gmp-gmpopenh264.enabled", false);
//user_pref("media.gmp-manager.url", "");

// PREF: Disable speculative pre-connections
user_pref("network.http.speculative-parallel-limit", 0);

// PREF: Disable downloading homepage snippets/messages from Mozilla
user_pref("browser.aboutHomeSnippets.updateUrl", "");

// PREF: Never check updates for search engines
user_pref("browser.search.update", false);

/*******************************************************************************
 * SECTION: Caching                                                            *
 ******************************************************************************/

// PREF: Permanently enable private browsing mode
//user_pref("browser.privatebrowsing.autostart", true);

// PREF: Do not download URLs for the offline cache
user_pref("browser.cache.offline.enable", false);

// PREF: Clear history when Firefox closes
//user_pref("privacy.sanitize.sanitizeOnShutdown", true);
//user_pref("privacy.clearOnShutdown.cache", true);
//user_pref("privacy.clearOnShutdown.cookies", true);
//user_pref("privacy.clearOnShutdown.downloads", true);
//user_pref("privacy.clearOnShutdown.formdata", true);
//user_pref("privacy.clearOnShutdown.history", true);
//user_pref("privacy.clearOnShutdown.offlineApps", true);
//user_pref("privacy.clearOnShutdown.sessions", true);
//user_pref("privacy.clearOnShutdown.openWindows", true);

// PREF: Set time range to "Everything" as default in "Clear Recent History"
user_pref("privacy.sanitize.timeSpan", 0);

// PREF: Clear everything but "Site Preferences" in "Clear Recent History"
user_pref("privacy.cpd.offlineApps", true);
user_pref("privacy.cpd.cache", true);
user_pref("privacy.cpd.cookies", true);
user_pref("privacy.cpd.downloads", true);
user_pref("privacy.cpd.formdata", true);
user_pref("privacy.cpd.history", true);
user_pref("privacy.cpd.sessions", true);

// PREF: Don't remember browsing history
//user_pref("places.history.enabled", false);

// PREF: Disable disk cache
user_pref("browser.cache.disk.enable", false);

// PREF: Disable memory cache (disabled)
//user_pref("browser.cache.memory.enable", false);

// PREF: Disable Caching of SSL Pages
//user_pref("browser.cache.disk_cache_ssl", false);

// PREF: Disable download history
//user_pref("browser.download.manager.retention", 0);

// PREF: Disable password manager
// CIS Version 1.2.0 October 21st, 2011 2.5.2
//user_pref("signon.rememberSignons", false);

// PREF: Disable form autofill, don't save information entered in web page forms and the Search Bar
//user_pref("browser.formfill.enable", false);

// PREF: Cookies expires at the end of the session (when the browser closes)
//user_pref("network.cookie.lifetimePolicy", 2);

// PREF: Require manual intervention to autofill known username/passwords sign-in forms
//user_pref("signon.autofillForms", false);

// PREF: When username/password autofill is enabled, still disable it on non-HTTPS sites
//user_pref("signon.autofillForms.http", false);

// PREF: Show in-content login form warning UI for insecure login fields
//user_pref("security.insecure_field_warning.contextual.enabled", true);

// PREF: Disable the password manager for pages with autocomplete=off (disabled)
// Does not prevent any kind of auto-completion (see browser.formfill.enable, signon.autofillForms)
//user_pref("signon.storeWhenAutocompleteOff", false);

// PREF: Delete Search and Form History
//user_pref("browser.formfill.expire_days", 0);

// PREF: Clear SSL Form Session Data
// Store extra session data for unencrypted (non-HTTPS) sites only.
// NOTE: CIS says 1, we use 2
//user_pref("browser.sessionstore.privacy_level", 2);

// PREF: Delete temporary files on exit
user_pref("browser.helperApps.deleteTempFileOnExit", true);

// PREF: Do not create screenshots of visited pages (relates to the "new tab page" feature)
user_pref("browser.pagethumbnails.capturing_disabled", true);

// PREF: Don't fetch and permanently store favicons for Windows .URL shortcuts created by drag and drop
// NOTICE: .URL shortcut files will be created with a generic icon
// Favicons are stored as .ico files in $profile_dir\shortcutCache
user_pref("browser.shell.shortcutFavicons", false);

// PREF: Disable bookmarks backups (default: 15)
//user_pref("browser.bookmarks.max_backups", 0);

/*******************************************************************************
 * SECTION: UI related                                                         *
 *******************************************************************************/

// PREF: Enable insecure password warnings (login forms in non-HTTPS pages)
user_pref("security.insecure_password.ui.enabled", true);

// PREF: Disable right-click menu manipulation via JavaScript (disabled)
//user_pref("dom.event.contextmenu.enabled", false);

// PREF: Disable "Are you sure you want to leave this page?" popups on page close
// Does not prevent JS leaks of the page close event.
//user_pref("dom.disable_beforeunload", true);

// PREF: Disable Downloading on Desktop
//user_pref("browser.download.folderList", 2);

// PREF: Always ask the user where to download
//user_pref("browser.download.useDownloadDir", false);

// PREF: Disable the "new tab page" feature and show a blank tab instead
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtab.url", "about:blank");

// PREF: Disable new tab tile ads & preload
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.directory.ping", "");
user_pref("browser.newtabpage.directory.source", "data:text/plain,{}");

// PREF: Enable Auto Notification of Outdated Plugins (Firefox < 50)
user_pref("plugins.update.notifyUser", true);

// PREF: Force Punycode for Internationalized Domain Names
user_pref("network.IDN_show_punycode", true);

// PREF: Disable inline autocomplete in URL bar
//user_pref("browser.urlbar.autoFill", false);
//user_pref("browser.urlbar.autoFill.typed", false);

// PREF: Disable CSS :visited selectors
user_pref("layout.css.visited_links_enabled", false);

// PREF: Disable URL bar autocomplete and history/bookmarks suggestions dropdown
//user_pref("browser.urlbar.autocomplete.enabled", false);

// PREF: Do not check if Firefox is the default browser
user_pref("browser.shell.checkDefaultBrowser", false);

// PREF: When password manager is enabled, lock the password storage periodically
user_pref("security.ask_for_password", 2);

// PREF: Lock the password storage every 1 minutes (default: 30)
user_pref("security.password_lifetime", 1);

// PREF: Display a notification bar when websites offer data for offline use
user_pref("browser.offline-apps.notify", true);
