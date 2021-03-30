
.ONESHELL :
SHELL := bash
.SHELLFLAGS := -euf -c

# clone git project and do stash/pull
# $(1) - git url
# $(2) - link
define clone_pull
	[ -e $(2)/.git ] || git clone -- $(1) $$(readlink -- $(2))
	git -C $(2) stash
	git -C $(2) pull
	git -C $(2) submodule update --init --recursive
endef

.PHONY : geant4
geant4 :
	$(call clone_pull,https://github.com/Geant4/geant4,$@)
	# centos: expat-devel, libXmu-devel
	cmake \
	    -DCMAKE_INSTALL_PREFIX="$(HOME)/.local/geant4.cern.ch" \
	    -DGEANT4_INSTALL_DATA=ON \
	    -DGEANT4_USE_QT=ON \
	    -DGEANT4_USE_OPENGL_X11=ON \
	    -S $@ -B $@/cmake-build
	$(MAKE) -C $@/cmake-build
	#$(MAKE) -C $@/cmake-build install

.PHONY : root
root :
	$(call clone_pull,https://github.com/root-project/root,$@)
	cmake \
	    -DCMAKE_INSTALL_PREFIX="$(HOME)/.local/root.cern.ch" \
	    -DCMAKE_CXX_STANDARD=17 \
	    -S $@ -B $@/cmake-build
	$(MAKE) -C $@/cmake-build
	#$(MAKE) -C $@/cmake-build install
