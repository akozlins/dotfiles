
.DEFAULT_GOAL := all

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
