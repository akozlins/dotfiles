#

.DEFAULT_GOAL := all

.ONESHELL :
SHELL := /bin/bash
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

all :

.PHONY : geant4
geant4 :
	$(call clone_pull,https://github.com/Geant4/geant4,$@)
	# centos: expat-devel, libXmu-devel
	cmake \
	    -DCMAKE_BUILD_TYPE=Release \
	    -DCMAKE_INSTALL_PREFIX="$(HOME)/.local/geant4.cern.ch" \
	    -DGEANT4_INSTALL_DATA=ON \
	    -DGEANT4_INSTALL_EXAMPLES=OFF \
	    -DGEANT4_USE_OPENGL_X11=ON \
	    -DGEANT4_USE_QT=ON \
	    -DGEANT4_USE_SYSTEM_CLHEP=ON \
	    -G Ninja \
	    -S $@ -B $@/cmake-build
	cmake --build $@/cmake-build

.PHONY : root
root :
	$(call clone_pull,https://github.com/root-project/root,$@)
	cmake \
	    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
	    -DCMAKE_INSTALL_PREFIX="$(HOME)/.local/root.cern.ch" \
	    -DCMAKE_CXX_STANDARD=17 \
	    -DLLVM_CXX_STD=c++17 \
	    -Ddavix=OFF -Dvdt=OFF -Dxrootd=OFF \
	    -G Ninja \
	    -S $@ -B $@/cmake-build
	cmake --build $@/cmake-build

.PHONY : clhep
clhep :
	$(call clone_pull,https://gitlab.cern.ch/CLHEP/CLHEP.git,$@)
	cmake \
	    -DCMAKE_BUILD_TYPE=Release \
	    -DCMAKE_INSTALL_PREFIX="$(HOME)/.local/clhep.cern.ch" \
	    -DCMAKE_CXX_STANDARD=17 \
	    -G Ninja \
	    -S $@ -B $(HOME)/.cache/CLHEP-cmake-build
	cmake --build $(HOME)/.cache/CLHEP-cmake-build
#	cmake --install $(HOME)/.cache/CLHEP-cmake-build
