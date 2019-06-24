
all : CustomCSSforFx users.js

CustomCSSforFx/.git :
	git clone https://github.com/Aris-t2/CustomCSSforFx

.PHONY : CustomCSSforFx
CustomCSSforFx : CustomCSSforFx/.git
	echo "Signature: 8a477f597d28d172789f06886806bc55" > "$@/CACHEDIR.TAG"
	( cd $@ && git stash && git pull )

user.js/.git :
	git clone https://github.com/pyllyukko/user.js

.PHONY : user.js
user.js :
	echo "Signature: 8a477f597d28d172789f06886806bc55" > "$@/CACHEDIR.TAG"
	( cd $@ && git stash && git pull )
