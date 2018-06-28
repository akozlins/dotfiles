
oh-my-zsh/.git:
	git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh

.PHONY: oh-my-zsh
oh-my-zsh: oh-my-zsh/.git
	touch oh-my-zsh/.borgexclude
	( cd oh-my-zsh && git stash && git pull )

far2l/.git:
	git clone --depth 1 https://github.com/elfmz/far2l

.PHONY: far2l
far2l: far2l/.git
	touch far2l/.borgexclude
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
	touch $@/.borgexclude
	# install python2 and gtk2
	( cd $@ && git stash && git pull )
	patch -p0 < fbpanel.patch
	( cd $@ && ./configure --prefix="$(HOME)/.local" && $(MAKE) install )

direnv/.git:
	git clone --depth 1 https://github.com/direnv/direnv
	( cd direnv && ln -s vendor src )

.PHONY: direnv
direnv: direnv/.git
	touch $@/.borgexclude
	( cd $@ && git submodule update --init --recursive )
	( cd $@ && GOPATH=$(shell pwd)/$@ $(MAKE) )
