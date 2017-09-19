#!/bin/bash
CACHE_DIR="/media/realroot/cache"
CACHE_LINK="/cache"

[[ -L $CACHE_LINK || -f $CACHE_LINK ]] && rm $CACHE_LINK
[[ -d $CACHE_DIR ]] || mkdir $CACHE_DIR
[[ -d $CACHE_LINK ]] || mkdir $CACHE_LINK
mountpoint $CACHE_LINK || mount -o bind $CACHE_DIR $CACHE_LINK
