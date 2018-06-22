
CustomCSSforFx/.git:
	git clone --depth 1 https://github.com/Aris-t2/CustomCSSforFx

.PHONY: CustomCSSforFx
CustomCSSforFx: CustomCSSforFx/.git
	touch $@/.borgexclude
	( cd $@ && git stash && git pull )
