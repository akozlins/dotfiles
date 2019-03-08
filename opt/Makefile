
oh-my-zsh/.git:
	git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh
	echo "Signature: 8a477f597d28d172789f06886806bc55" > "oh-my-zsh/CACHEDIR.TAG"

.PHONY: oh-my-zsh
oh-my-zsh: oh-my-zsh/.git
	( cd oh-my-zsh && git stash && git pull )

far2l/.git:
	git clone --depth 1 https://github.com/elfmz/far2l
	echo "Signature: 8a477f597d28d172789f06886806bc55" > "far2l/CACHEDIR.TAG"

.PHONY: far2l
far2l: far2l/.git
	# install cmake, wxgtk2 (wxWidgets)
	( cd far2l && git stash && git pull )
	patch -p0 < far2l.patch
	mkdir -p far2l/build
	( cd far2l/build && cmake -DCMAKE_BUILD_TYPE=Release .. )
	$(MAKE) -C far2l/build

fbpanel/.git :
	( cd ../.cache && git clone https://github.com/aanatoly/fbpanel )

.PHONY : fbpanel
fbpanel : fbpanel/.git
	# install python2 and gtk2
	( cd fbpanel && git stash && git pull )
	patch -d fbpanel -p1 < fbpanel.patch
	( cd fbpanel && ./configure --prefix="$(HOME)/.local" && $(MAKE) && $(MAKE) install )

direnv/.git:
	git clone --depth 1 https://github.com/direnv/direnv
	( cd direnv && ln -s vendor src )
	echo "Signature: 8a477f597d28d172789f06886806bc55" > "direnv/CACHEDIR.TAG"

.PHONY: direnv
direnv: direnv/.git
	( cd $@ && git pull && git submodule update --init --recursive )
	( cd $@ && GOPATH=$(shell pwd)/$@ $(MAKE) )
