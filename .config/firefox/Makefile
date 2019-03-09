
CustomCSSforFx/.git :
	git clone https://github.com/Aris-t2/CustomCSSforFx
	echo "Signature: 8a477f597d28d172789f06886806bc55" > "CustomCSSforFx/CACHEDIR.TAG

.PHONY : CustomCSSforFx
CustomCSSforFx : CustomCSSforFx/.git
	( cd $@ && git stash && git pull )
