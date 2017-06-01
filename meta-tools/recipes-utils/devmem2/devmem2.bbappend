LIC_FILES_CHKSUM = "file://devmem2.c;endline=38;md5=a9eb9f3890384519f435aedf986297cf"

SRC_URI = "http://www.free-electrons.com/pub/mirror/devmem2.c;downloadfilename=devmem2-new.c \
           file://devmem2-fixups-2.patch;apply=yes;striplevel=0"

SRC_URI[md5sum] = "e23f236e94be4c429aa1ceac0f01544b"
SRC_URI[sha256sum] = "3b15515693bae1ebd14d914e46d388edfec2175829ea1576a7a0c8606ebbe639"

python do_unpack_append() {
    os.rename("devmem2-new.c", "devmem2.c")
}
