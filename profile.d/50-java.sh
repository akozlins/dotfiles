#!/bin/sh

#mkdir -p -- "$(readlink -f -- "$DOTFILES/.java")"

# Java Usage Tracker
# https://docs.oracle.com/javacomponents/usage-tracker/overview/toc.htm
# * disable last usage time tracking
JAVA_USAGE_TRACKER=" \
-Dcom.oracle.usagetracker.config.file=$XDG_CONFIG_HOME/java/usagetracker.properties \
-Djdk.disableLastUsageTracking=true \
"
# Java Font Anti-Aliasing
# https://wiki.archlinux.org/index.php/java
# https://docs.oracle.com/javase/8/docs/technotes/guides/2d/flags.html
JAVA_FONT_AA=" \
-Dawt.useSystemAAFontSettings=on \
-Dswing.aatext=true \
"
# Java options
# https://docs.oracle.com/javase/8/docs/platform/jvmti/jvmti.html
export JAVA_TOOL_OPTIONS="$JAVA_USAGE_TRACKER $JAVA_FONT_AA"
# user home directory
export JAVA_TOOL_OPTIONS="$JAVA_TOOL_OPTIONS -Duser.home=$DOTFILES"
# preferences API
#export JAVA_TOOL_OPTIONS="$JAVA_TOOL_OPTIONS -Djava.util.prefs.userRoot=$XDG_CACHE_HOME/java/.userPrefs"
# enable OpenGL-based pipeline
#export JAVA_TOOL_OPTIONS="$JAVA_TOOL_OPTIONS -Dsun.java2d.opengl=true"
# disable IPv6
export JAVA_TOOL_OPTIONS="$JAVA_TOOL_OPTIONS -Djava.net.preferIPv4Stack=true"
