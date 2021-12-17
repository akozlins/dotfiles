#

## pacman

```
# mark all packages as non-explicitly installed
sudo pacman -D --asdeps $(pacman -Qqe)
# mark base packages as explicitly installed
sudo pacman -D --asexplicit base
# list unrequired and optional dependencies
pacman -Qdtt
# mark package as explicitly installed
sudo pacman -D --asexplicit <package>
# ...
pacman -Qe | awk '{print $1}' | xargs -n 1 pactree -r -d 1
```

## fonts

- `xorg-fonts-misc`
- `noto-fonts`, `noto-fonts-cjk`

```
xset fp default
xset fp rehash
```
