
install:
	./install.sh

.PHONY: far2l

far2l:
	if [[ ! -d far2l ]] ; then \
	git clone --depth 1 https://github.com/elfmz/far2l ; fi
	cd far2l; \
	mkdir build; cd build; \
	cmake ..; \
	make; \
