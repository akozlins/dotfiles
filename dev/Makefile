
.ONESHELL :
#.SHELLFLAGS = -e

geant4/.git :
	cd ../.cache
	git clone https://github.com/Geant4/geant4

.PHONY : geant4
geant4 : geant4/.git
	mkdir -p geant4/build
	cd geant4/build
	cmake \
	    -DCMAKE_INSTALL_PREFIX="$(HOME)/.local" \
	    -DGEANT4_INSTALL_DATA=ON \
	    -DGEANT4_USE_QT=ON \
	    -DGEANT4_USE_OPENGL_X11=ON \
	    ..
	$(MAKE)
