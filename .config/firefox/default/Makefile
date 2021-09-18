
.DEFAULT_GOAL := all

SHELL := bash
.SHELLFLAGS := -euf -c

define clone_pull
	[ -e $(2)/.git ] || git clone -- $(1) $$(readlink -- $(2))
	git -C $(2) stash
	git -C $(2) pull
	git -C $(2) submodule update --init --recursive
endef

all : chrome/CustomCSSforFx user.js

.PHONY : chrome/CustomCSSforFx
chrome/CustomCSSforFx :
	$(call clone_pull,https://github.com/Aris-t2/CustomCSSforFx,$@)

GENERATE := $(XDG_CONFIG_HOME)/firefox/user.js/generate.py

.PHONY : user.js
user.js :
	if [ -e "user.js" ] && ! diff -- "user.js" <($(GENERATE)) ; then \
	    cp -v -- "user.js" "user.$$(date +%FT%T).js"; \
	    $(GENERATE) > "user.js"; \
	fi
