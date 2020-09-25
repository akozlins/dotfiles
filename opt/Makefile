
PREFIX := $(HOME)/.local
CMAKE_OPTS := -DCMAKE_INSTALL_PREFIX=$(PREFIX) -DCMAKE_BUILD_TYPE=Release

# clone git project and do stash/pull
define clone_pull
	[ -e $(2)/.git ] || git clone -- $(1) $$(readlink -- $(2))
	git -C $(2) stash
	git -C $(2) pull
	git -C $(2) submodule update --init --recursive
endef

# generate cmake build system and do make/install
define cmake_make_install
	# dependencies: cmake, pkg-config
	cmake -S $(1) -B $(1)/build $(CMAKE_OPTS)
	$(MAKE) -C $(1)/build
	$(MAKE) -C $(1)/build install
endef

.PHONY : oh-my-zsh
oh-my-zsh :
	$(call clone_pull,https://github.com/robbyrussell/oh-my-zsh,$@)

far2l/history :
	mkdir -pv far2l/history/k-Editor/k-LastPositions
	mkdir -pv far2l/history/k-SavedDialogHistory
	mkdir -pv far2l/history/k-SavedFolderHistory
	mkdir -pv far2l/history/k-SavedHistory
	mkdir -pv far2l/history/k-SavedViewHistory
	mkdir -pv far2l/history/k-Viewer/k-LastPositions

.PHONY : far2l
far2l :
	$(call clone_pull,https://github.com/elfmz/far2l,far2l)
	make far2l/history
	# install g++, cmake, patch, m4, pkg-config, gawk
	# - Arch: wxgtk2
	# - Fedora, CentOS: wxGTK3-devel
	# - Debian: libwxgtk3-dev
	# - Ubuntu: libwxgtk3.0-gtk3-dev, libglib2.0-dev
	patch -d far2l -p1 < far2l.patch
	$(call cmake_make_install,$@)

.PHONY : fbpanel
fbpanel :
	$(call clone_pull,https://github.com/akozlins/fbpanel,$@)
	# install gcc, cmake, gtk2
	# - Debian: libgtk2.0-dev, libglib2.0-dev
	# - CentOS: gtk2-devel
	# - Ubuntu: libgtk2.0-dev
	$(call cmake_make_install,$@)

.PHONY : direnv
direnv :
	$(call clone_pull,https://github.com/direnv/direnv,$@)
	$(MAKE) -C $@ DESTDIR=$(PREFIX) install

.PHONY : xss-lock
xss-lock :
	$(call clone_pull,https://bitbucket.org/raymonad/xss-lock,$@)
	$(call cmake_make_install,$@)
