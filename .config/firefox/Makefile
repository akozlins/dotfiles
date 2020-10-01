
.DEFAULT_GOAL := all

SHELL := bash
.SHELLFLAGS := -euf -c

define clone_pull
	[ -e $(2)/.git ] || git clone -- $(1) $(2)
	git -C $(2) stash
	git -C $(2) pull
endef

all : CustomCSSforFx ghacks-users.js

default/user.js : user.js/my.js user.js/ghacks.js ghacks-user.js/user.js
	./user.js/make.sh

.PHONY : CustomCSSforFx
CustomCSSforFx :
	$(call clone_pull,https://github.com/Aris-t2/CustomCSSforFx,$@)

.PHONY : ghacks-user.js
ghacks-user.js :
	$(call clone_pull,https://github.com/ghacksuserjs/ghacks-user.js,$@)

# update default profile
.PHONY : default
default :
	if [ -e "$@/user.js" ] && ! diff -- "$@/user.js" <(./user.js/make.py) ; then \
	    cp -v -- "$@/user.js" "$@/user.$$(date +%FT%T).js"; \
	    ./user.js/generate.py > "$@/user.js"; \
	fi
