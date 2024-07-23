#

.DEFAULT_GOAL := all

.ONESHELL :
SHELL := bash
.SHELLFLAGS := -euf -c

PREFIX := $(HOME)/.local
CMAKE_OPTS := -DCMAKE_INSTALL_PREFIX="$(PREFIX)" -DCMAKE_BUILD_TYPE=Release -G Ninja

# clone git project and do stash/pull
# $(1) - git url
# $(2) - link
define clone_pull
	[ -e $(2)/.git ] || git clone -- $(1) $$(readlink -- $(2))
	git -C $(2) stash
	git -C $(2) pull
	git -C $(2) submodule update --init --recursive
endef

# generate cmake build system and do make/install
define cmake_make_install
	# dependencies: cmake, pkg-config
	cmake -S "$(1)" -B "$(1)/cmake-build" $(CMAKE_OPTS)
	cmake --build $(1)/cmake-build -j
	cmake --install $(1)/cmake-build
	#$(MAKE) $(MAKEFLAGS) -C $(1)/cmake-build
	#$(MAKE) -C $(1)/cmake-build install
endef

all :

.PHONY : oh-my-zsh
oh-my-zsh :
	$(call clone_pull,https://github.com/robbyrussell/oh-my-zsh,$@)

far2l : CMAKE_OPTS += -DALIGN=0 -DAUTOWRAP=0 -DCALC=0 -DCOMPARE=0 -DDRAWLINE=0 -DEDITCASE=0 -DEDITORCOMP=0 -DFILECASE=0 -DINCSRCH=0 -DINSIDE=0 -DNETROCKS=0 -DSIMPLEINDENT=0
#far2l : CMAKE_OPTS += -DDUSEWX=no
.PHONY : far2l
far2l :
	$(call clone_pull,https://github.com/elfmz/far2l,far2l)
	# install g++ cmake patch m4 pkg-config gawk
	# - Arch: wxwidgets-gtk3 spdlog xerces-c
	# - Fedora, CentOS: wxGTK3-devel
	# - Debian: libwxgtk3-dev
	# - Ubuntu: libwxgtk3.0-gtk3-dev libglib2.0-dev
	# - OpenSuse: m4 libuchardet-devel wxWidgets-3_0-devel spdlog-devel libxerces-c-devel
	patch -d far2l -p1 < far2l.patch
	$(call cmake_make_install,$@)

.PHONY : fbpanel
fbpanel :
	$(call clone_pull,https://github.com/akozlins/fbpanel,$@)
	# install gcc, cmake, gtk2
	# - Arch: gdk-pixbuf-xlib
	# - Debian: libgtk2.0-dev libglib2.0-dev
	# - CentOS: gtk2-devel
	# - Ubuntu: libgtk2.0-dev
	# - OpenSuse: gtk2-devel
	$(call cmake_make_install,$@)

.PHONY : direnv
direnv :
	$(call clone_pull,https://github.com/direnv/direnv,$@)
	$(MAKE) $(MAKEFLAGS) -C $@ DESTDIR=$(PREFIX) install

.PHONY : xss-lock
xss-lock :
	# - OpenSuse: gtk2-devel xcb-util-devel xorg-x11-devel
	$(call clone_pull,https://bitbucket.org/raymonad/xss-lock,$@)
	$(call cmake_make_install,$@)

.PHONY : easystroke
easystroke :
	# - Arch: gtkmm3 vala xorg-server-devel
	# - OpenSuse: gtkmm3-devel dbus-1-glib-devel libboost_serialization1_75_0-devel libboost_filesystem1_75_0-devel vala xorg-x11-server-sdk
	$(call clone_pull,https://github.com/akozlins/easystroke,$@)
	$(call cmake_make_install,$@)

.PHONY : anorack
anorack :
	$(call clone_pull,https://github.com/jwilk/anorack,$@)
	$(MAKE) $(MAKEFLAGS) -C $@ PREFIX=$(PREFIX) install

yay-bin :
	$(call clone_pull,https://aur.archlinux.org/yay-bin,$@)
	( cd yay-bin && makepkg -s && makepkg -i )
