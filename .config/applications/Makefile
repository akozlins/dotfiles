#

all : $(patsubst %.in, share/%, $(wildcard *.desktop.in))

share/%.desktop : %.desktop.in share
	./envsubst.sh < $< > $@

share/mimeapps.list : mimeapps.list share
	cp -v -- $< $@

share :
	mkdir -pv -- "$$(readlink -f -- $@)"
