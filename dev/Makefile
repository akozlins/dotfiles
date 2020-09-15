
.ONESHELL :
#.SHELLFLAGS = -e

geant4/.git :
	git clone https://github.com/Geant4/geant4 "$$(readlink -- geant4)"

.PHONY : geant4
geant4 : geant4/.git
	# centos: expat-devel, libXmu-devel
	mkdir -p geant4/cmake-build
	cd geant4/cmake-build
	cmake \
	    -DCMAKE_INSTALL_PREFIX="$(HOME)/.local/geant4.cern.ch" \
	    -DGEANT4_INSTALL_DATA=ON \
	    -DGEANT4_USE_QT=ON \
	    -DGEANT4_USE_OPENGL_X11=ON \
	    ..
	$(MAKE)
	#$(MAKE) install

root/.git :
	git clone https://github.com/root-project/root "$$(readlink -- root)"

.PHONY : root
root : root/.git
	mkdir -p root/cmake-build
	cd root/cmake-build
	cmake \
	    -DCMAKE_INSTALL_PREFIX="$(HOME)/.local/root.cern.ch" \
	    -DCMAKE_CXX_STANDARD=14 \
	    ..
	$(MAKE)
	#$(MAKE) install
