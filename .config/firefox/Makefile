
.DEFAULT_GOAL := all

SHELL := bash
.SHELLFLAGS := -euf -c

all : CustomCSSforFx ghacks-users.js

default/user.js : user.js/my.js user.js/ghacks.js ghacks-user.js/user.js
	./user.js/make.sh

CustomCSSforFx/.git :
	git clone https://github.com/Aris-t2/CustomCSSforFx

.PHONY : CustomCSSforFx
CustomCSSforFx : CustomCSSforFx/.git
	echo "Signature: 8a477f597d28d172789f06886806bc55" > "$@/CACHEDIR.TAG"
	( cd $@ && git stash && git pull )

ghacks-user.js/.git :
	git clone https://github.com/ghacksuserjs/ghacks-user.js

.PHONY : ghacks-user.js
ghacks-user.js : ghacks-user.js/.git
	echo "Signature: 8a477f597d28d172789f06886806bc55" > "$@/CACHEDIR.TAG"
	( cd $@ && git stash && git pull )

.PHONY : default
default :
	if [ -e "$@/user.js" ] && ! diff -- "$@/user.js" <(./user.js/make.py) ; then \
	    cp -v -- "$@/user.js" "$@/user.$$(date +%FT%T).js"; \
	    ./user.js/generate.py > "$@/user.js"; \
	fi
