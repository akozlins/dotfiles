
PREFIX := $(HOME)/.local
CMAKE_OPTS := -DCMAKE_INSTALL_PREFIX=$(PREFIX) -DCMAKE_BUILD_TYPE=Release

oh-my-zsh/.git :
	git clone https://github.com/robbyrussell/oh-my-zsh "$$(readlink -- oh-my-zsh)"

.PHONY : oh-my-zsh
oh-my-zsh : oh-my-zsh/.git
	( cd $@ && git stash && git pull )

far2l/.git :
	git clone https://github.com/elfmz/far2l "$$(readlink -- far2l)"

far2l/history : far2l/.git
	mkdir -pv far2l/history/k-Editor/k-LastPositions
	mkdir -pv far2l/history/k-SavedDialogHistory
	mkdir -pv far2l/history/k-SavedFolderHistory
	mkdir -pv far2l/history/k-SavedHistory
	mkdir -pv far2l/history/k-SavedViewHistory
	mkdir -pv far2l/history/k-Viewer/k-LastPositions

.PHONY : far2l
far2l : far2l/.git far2l/history
	( cd $@ && git stash && git pull )
	# install g++, cmake, patch, m4, pkg-config, gawk
	# - Arch: wxgtk2
	# - Fedora, CentOS: wxGTK3-devel
	# - Debian: libwxgtk3-dev
	# - Ubuntu: libwxgtk3.0-gtk3-dev, libglib2.0-dev
	patch -d far2l -p1 < far2l.patch
	mkdir -pv far2l/build
	( cd far2l/build && cmake $(CMAKE_OPTS) .. && $(MAKE) && $(MAKE) install )

fbpanel/.git :
	git clone https://github.com/akozlins/fbpanel "$$(readlink -- fbpanel)"

.PHONY : fbpanel
fbpanel : fbpanel/.git
	( cd $@ && git stash && git pull )
	# install gcc, cmake, gtk2
	# - Debian: libgtk2.0-dev, libglib2.0-dev
	# - CentOS: gtk2-devel
	mkdir fbpanel/build
	( cd fbpanel/build && cmake $(CMAKE_OPTS) .. && $(MAKE) install )

direnv/.git :
	git clone https://github.com/direnv/direnv "$$(readlink -- direnv)"
	( cd direnv && ln -snv vendor src )

.PHONY : direnv
direnv : direnv/.git
	( cd $@ && git stash && git pull && git submodule update --init --recursive )
	( cd direnv && GOPATH=$(shell pwd)/$@ $(MAKE) )
