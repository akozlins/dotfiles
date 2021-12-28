
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

PROFILE := $(DOTFILES)/.mozilla/firefox/default

.PHONY : user.js
user.js :
	make -C ..
	if [ -e "$(PROFILE)/user.js" ] && ! diff -- <(cat "$(PROFILE)/user.js" | sort) <($(GENERATE) | sort) ; then \
	    cp -v -- "$(PROFILE)/user.js" "$(PROFILE)/user.$$(date +%FT%T).js"; \
	    $(GENERATE) > "$(PROFILE)/user.js"; \
	fi
