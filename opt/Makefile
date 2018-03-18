
.PHONY: install
install:
	./install.sh

oh-my-zsh/.git:
	git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh

.PHONY: oh-my-zsh
oh-my-zsh: oh-my-zsh/.git
	( cd oh-my-zsh && git stash && git pull )
	patch -p0 < oh-my-zsh.patch

far2l/.git:
	git clone --depth 1 https://github.com/elfmz/far2l

.PHONY: far2l
far2l: far2l/.git
	# install cmake, wxgtk2 (wxWidgets)
	( cd far2l && git stash && git pull )
	patch -p0 < far2l.patch
	mkdir -p far2l/build
	( cd far2l/build && cmake -DCMAKE_BUILD_TYPE=Release .. )
	$(MAKE) -C far2l/build

fbpanel/.git:
	git clone --depth 1 https://github.com/aanatoly/fbpanel

.PHONY: fbpanel
fbpanel: fbpanel/.git
	# install python2 and gtk2
	( cd fbpanel && git stash && git pull )
	patch -p0 < fbpanel.patch
	( cd fbpanel && ./configure --prefix="$(HOME)/.local" )
	$(MAKE) -C fbpanel
	$(MAKE) -C fbpanel install

.PHONY: direnv
direnv: direnv/.git
	( cd direnv && ln -s vendor src )
	GOPATH=$(pwd) $(MAKE) -C direnv
