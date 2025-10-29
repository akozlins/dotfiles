#!/bin/bash
set -euf

DOTFILES=$(dirname -- "$(readlink -f -- "$0")")
echo "DOTFILES = '$DOTFILES'"
unset CDPATH
cd "$DOTFILES" || exit 1

# find all links
links=()
while IFS='' read -r line ; do
    links+=("$line")
done < <(find . -xtype l | awk '{ print length, $0 }' | sort -n | cut -d' ' -f2-)

# do mkdir for each link
for link in "${links[@]}" ; do
    if [ ! -L "$link" ] ; then
        >&2 echo "E [$0] '$link' is not of link type"
        exit 1
    fi
    target=$(readlink -m -- "$link")

    # skip existing targets
    [ -e "$target" ] && continue
    # check git ignore
    [ -n "$(git check-ignore -v "$link")" ] && continue
    # skip file targets (*.*)
    if [[ $(basename -- "$target") = *.* ]] ; then
        >&2 echo "I [$0] skip file link: '$link' -> '$target'"
        continue
    fi
    # skip ext (outside $HOME) targets
    [[ $target = $HOME/* ]] || continue

    # mkdir (assume target should be directory)
    mkdir -pv -- "$target"
done

# make links for targets (ln $DOTFILES/target $HOME/target)
targets=(
    bin

    .config
    .var

    .bashrc .zshrc
    .profile
)

# create links that point to targets
for target in "${targets[@]}" ; do
    link="$HOME/$target"
    target="$DOTFILES/$target"

    if [ ! -e "$target" ] ; then
        >&2 echo "E [$0] target '$target' does not exist"
        exit 1
    fi

    link_dir=$(dirname -- "$link")

    # skip same links
    if [ -L "$link" ] ; then
        if command -v realpath &> /dev/null ; then
            [ "$(readlink -- "$link")" = "$(realpath --relative-to="$link_dir" "$target")" ] && continue
        else
            [ "$(readlink -- "$link")" = "$target" ] && continue
        fi
    fi

    # delete existing link
    if [ -L "$link" ] ; then
        >&2 echo "I [$0] link '$link -> $(readlink -- "$link")' exists"
        while true ; do
            read -r -p "Overwrite? [y,n,q,?] " sel
            case "$sel" in
                y) rm -fv -- "$link" ; break ;;
                n) continue 2 ;;
                q) exit 1 ;;
                *) continue ;;
            esac
        done
    elif [ -e "$link" ] ; then
        >&2 echo "W [$0] file '$link' exists"
        while true ; do
            read -r -p "Overwrite? [y,n,q,?] " sel
            case "$sel" in
                y) rm -rfv -- "$link" ; break ;;
                n) continue 2 ;;
                q) exit 1 ;;
                *) continue ;;
            esac
        done
    fi

    # make destination directory
    if [ ! -d "$link_dir" ] ; then
        mkdir -pv -- "$link_dir"
    fi

    if command -v realpath &> /dev/null ; then
        # create relative link
        target=$(realpath --relative-to="$link_dir" "$target")
        ln -snv --relative -T "$target" "$link"
    else
        # create normal link
        ln -snv -T "$target" "$link"
    fi
done

# Media/MIME Types
make -C "$DOTFILES/.config/applications"

source .profile
while IFS='' read -r f ; do
    [ -f "$f" ] && source "$f"
done < <(find "$DOTFILES/install.d/" -name '*.sh')
