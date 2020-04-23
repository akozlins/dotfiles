
oh-my-zsh/.git :
	( cd ../.local/share && git clone https://github.com/robbyrussell/oh-my-zsh )

.PHONY : oh-my-zsh
oh-my-zsh : oh-my-zsh/.git
	( cd $@ && git stash && git pull )

far2l/.git :
	( cd ../.local/share && git clone https://github.com/elfmz/far2l )

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
	# install cmake, wxgtk2 (wxWidgets)
	patch -d far2l -p1 < far2l.patch
	mkdir -pv far2l/build
	( cd far2l/build && cmake -DCMAKE_BUILD_TYPE=Release .. && $(MAKE) )

fbpanel/.git :
	( cd ../.local/share && git clone https://github.com/aanatoly/fbpanel )

.PHONY : fbpanel
fbpanel : fbpanel/.git
	( cd $@ && git stash && git pull )
	# install gcc, patch, gtk2 and python2
	patch -d fbpanel -p1 < fbpanel.patch
	( cd fbpanel && ./configure --prefix="$(HOME)/.local" && $(MAKE) V=1 && $(MAKE) install )

direnv/.git :
	( cd ../.local/share && git clone https://github.com/direnv/direnv )
	( cd direnv && ln -snv vendor src )

.PHONY : direnv
direnv : direnv/.git
	( cd $@ && git stash && git pull && git submodule update --init --recursive )
	( cd direnv && GOPATH=$(shell pwd)/$@ $(MAKE) )
