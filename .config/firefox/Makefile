
.DEFAULT_GOAL := all

SHELL := bash
.SHELLFLAGS := -euf -c

define clone_pull
	[ -e $(2)/.git ] || git clone -- $(1) $$(readlink -- $(2))
	git -C $(2) stash
	git -C $(2) pull
	git -C $(2) submodule update --init --recursive
endef

all : ghacks-user.js

.PHONY : ghacks-user.js
ghacks-user.js :
	$(call clone_pull,https://github.com/arkenfox/user.js,$@)
