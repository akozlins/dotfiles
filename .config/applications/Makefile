#

all : share/mimeapps.list $(patsubst %.in, share/%, $(wildcard *.desktop.in))

share/%.desktop : %.desktop.in share
	./envsubst.sh < $< > $@

share/mimeapps.list : mimeapps.list share
	cat $< > $@

share :
	mkdir -pv -- "$$(readlink -f -- $@)"
