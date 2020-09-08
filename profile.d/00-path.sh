#!/bin/sh

my_path_push_front() {
    case ":$PATH:" in
        *:"$1":*) ;;
        ::) PATH="$1" ;;
        *) PATH="$1:$PATH" ;;
    esac
}
