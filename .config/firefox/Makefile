
.DEFAULT_GOAL := all

SHELL := bash
.SHELLFLAGS := -euf -c

define clone_pull
	[ -e "$(2)/.git" ] || [ ! -L $(2) ] || git clone -- $(1) $$(readlink -- $(2))
	[ -e "$(2)/.git" ] || git clone -- "$(1)" "$(2)"
	git -C "$(2)" stash
	git -C "$(2)" pull
	git -C "$(2)" submodule update --init --recursive
endef

all : ghacks-user.js

.PHONY : ghacks-user.js
ghacks-user.js :
	$(call clone_pull,https://github.com/arkenfox/user.js,$@)


GENERATE := $(XDG_CONFIG_HOME)/firefox/user.js/generate.py
PROFILE := $(XDG_DATA_HOME)/firefox/default

default : user.js css
	rsync -auv ./default/ $(PROFILE)/

.PHONY : user.js
user.js : ghacks-user.js
	mkdir -p -- "$(PROFILE)"
	$(GENERATE) --home=$(XDG_CONFIG_HOME)/firefox \
	    ghacks-user.js/user.js \
	    user.js/ghacks.js \
	    user.js/my.js \
	| sort > "$(PROFILE)/user.js.new"
	if [ -e "$(PROFILE)/user.js" ] && ! diff -u -- <(cat "$(PROFILE)/user.js" | sort) <(cat "$(PROFILE)/user.js.new" | sort) ; then \
	    cp -v -- "$(PROFILE)/user.js" "$(PROFILE)/user.$$(date +%FT%T).js"; \
	fi
	mv -v -- "$(PROFILE)/user.js.new" "$(PROFILE)/user.js"

.PHONY : css
css :
	# TODO: copy default/chrome
	mkdir -p -- "$(PROFILE)/chrome"
	$(call clone_pull,https://github.com/Aris-t2/CustomCSSforFx,$(PROFILE)/chrome/CustomCSSforFx)
