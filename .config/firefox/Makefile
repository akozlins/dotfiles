
.DEFAULT_GOAL := all

SHELL := bash
.SHELLFLAGS := -euf -c

define clone_pull
	[ -e $(2)/.git ] || git clone -- $(1) $(2)
	git -C $(2) stash
	git -C $(2) pull
endef

all : ghacks-users.js

.PHONY : ghacks-user.js
ghacks-user.js :
	$(call clone_pull,https://github.com/arkenfox/user.js,$@)
