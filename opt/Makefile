
oh-my-zsh/.git :
	( cd ../.cache && git clone https://github.com/robbyrussell/oh-my-zsh )

.PHONY : oh-my-zsh
oh-my-zsh : oh-my-zsh/.git
	( cd oh-my-zsh && git stash && git pull )

far2l/.git :
	( cd ../.cache && git clone https://github.com/elfmz/far2l )

far2l/history : far2l/.git
	mkdir -vp far2l/history/k-Editor/k-LastPositions
	mkdir -vp far2l/history/k-SavedDialogHistory
	mkdir -vp far2l/history/k-SavedFolderHistory
	mkdir -vp far2l/history/k-SavedHistory
	mkdir -vp far2l/history/k-SavedViewHistory
	mkdir -vp far2l/history/k-Viewer/k-LastPositions

.PHONY : far2l
far2l : far2l/.git far2l/history
	# install cmake, wxgtk2 (wxWidgets)
	( cd far2l && git stash && git pull )
	patch -d far2l -p1 < far2l.patch
	mkdir -p far2l/build
	( cd far2l/build && cmake -DCMAKE_BUILD_TYPE=Release .. && $(MAKE) )

fbpanel/.git :
	( cd ../.cache && git clone https://github.com/aanatoly/fbpanel )

.PHONY : fbpanel
fbpanel : fbpanel/.git
	# install gcc, patch, gtk2 and python2
	( cd fbpanel && git stash && git pull )
	patch -d fbpanel -p1 < fbpanel.patch
	( cd fbpanel && ./configure --prefix="$(HOME)/.local" && $(MAKE) V=1 && $(MAKE) install )

direnv/.git :
	( cd ../.cache && git clone https://github.com/direnv/direnv )
	( cd direnv && ln -s vendor src )

.PHONY : direnv
direnv : direnv/.git
	( cd direnv && git pull && git submodule update --init --recursive )
	( cd direnv && GOPATH=$(shell pwd)/$@ $(MAKE) )
