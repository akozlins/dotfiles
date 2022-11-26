//

// PREF: Set Firefox locale to en-US
user_pref("general.useragent.locale", "en-US");

user_pref("browser.bookmarks.restore_default_bookmarks", false);
user_pref("browser.bookmarks.showMobileBookmarks", false);
user_pref("browser.bookmarks.showRecentlyBookmarked", false);

user_pref("browser.ctrlTab.previews", true);

user_pref("browser.download.animateNotifications", false);

user_pref("browser.fullscreen.animate", false);

user_pref("browser.link.open_newwindow", 3);
user_pref("browser.link.open_newwindow.override.external", 3);
user_pref("browser.link.open_newwindow.restriction", 0);

user_pref("browser.search.defaultenginename", "DuckDuckGo");
user_pref("browser.search.widget.inNavBar", false);

user_pref("browser.sessionstore.interval", 300000);
user_pref("browser.sessionstore.max_tabs_undo", 16);
user_pref("browser.sessionstore.restore_on_demand", false);

// resume previous browser session
user_pref("browser.startup.page", 3);

user_pref("browser.tabs.animate", false);
user_pref("browser.tabs.closeWindowWithLastTab", false);
user_pref("browser.tabs.insertRelatedAfterCurrent", false);
user_pref("browser.tabs.tabMaxWidth", 120);
user_pref("browser.tabs.tabMinWidth", 120);
user_pref("browser.tabs.warnOnClose", false);

user_pref("general.smoothScroll", false);
user_pref("general.warnOnAboutConfig", false);

user_pref("pdfjs.defaultZoomValue", "page-width");

user_pref("print.print_resolution", 600);
user_pref("print.print_paper_name", "iso_a4");
user_pref("print.print_orientation", 0);

user_pref("network.proxy.type", 2);
user_pref("network.proxy.autoconfig_url", "file://" + FIREFOX_HOME + "/proxy.pac");

user_pref("ui.key.menuAccessKeyFocuses", false);

user_pref("media.default_volume", "0.2");

// handle middle-clicks normally
user_pref("middlemouse.contentLoadURL", false);

// disable reading installed plugins
user_pref("plugins.enumerable_names", "");

// disable autoplay
user_pref("media.autoplay.default", 5);
user_pref("media.autoplay.enabled", false);
user_pref("media.autoplay.allow-muted", false);
user_pref("media.autoplay.enabled.user-gestures-needed", false);

// default permissions
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 2);

user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("media.av1.enabled", true);
user_pref("mousewheel.with_control.action", 0);



/******************************************************************************
******************************************************************************/

user_pref("browser.download.autohideButton", false);

user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.screenshots.disabled", true);

user_pref("reader.parse-on-load.enabled", false);

user_pref("geo.enabled", false);

user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

user_pref("browser.urlbar.update1", false);
user_pref("browser.urlbar.openViewOnFocus", false);



user_pref("dom.security.https_only_mode", false);

// disable Ctrl+q
user_pref("browser.quitShortcut.disabled", true);

// disable proton interface
user_pref("browser.proton.enabled", false);

// Ctrl+Tab cycles through tabs in recently used order
user_pref("browser.ctrlTab.sortByRecentlyUsed", true);

// compact mode
user_pref("browser.uidensity", 1);

user_pref("signon.includeOtherSubdomainsInLookup", false);

// always ask where to save files
user_pref("browser.download.useDownloadDir", false);

// always show scrollbar
user_pref("widget.gtk.overlay-scrollbars.enabled", false);

user_pref("browser.tabs.allowTabDetach", false);

user_pref("accessibility.blockautorefresh", true);

// enable logins csv import
user_pref("signon.management.page.fileImport.enabled", true);

//
user_pref("accessibility.blockautorefresh", true);

user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
