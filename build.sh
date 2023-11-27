#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NORM="\e[0m"

CC="clang"
INC="-I/usr/include/freetype2"
CFLAGS="-pipe -DXINERAMA -DVERSION=\"6.3\" -w -Ofast -flto -mavx -maes -flto -march=x86-64 -msse4.1 ${INC}"
LIBS="-L/usr/X11R6/lib -lX11 -lXinerama -lfontconfig -lXft"
OUT="dwm"
BIN="bin"

mkdir -p bin
cp config.def.h config.h

function build_info () {
  echo -e "${YELLOW}[BUILD]${NORM} $1"
}

if [ "$1" = "clean" ]; then
  echo -e "${YELLOW}[CLEAN]${NORM} Removing binaries..."
  rm -rf bin
  echo -e "${YELLOW}[CLEAN]${GREEN} Done.${NORM}"
  exit 0
fi

if [ "$1" = "install" ]; then
  echo -e "${YELLOW}[CLEAN]${NORM} Installing..."
  cp ${BIN}/${OUT} /usr/bin/dwm
  chmod +x /usr/bin/dwm
  echo -e "${YELLOW}[CLEAN]${GREEN} Done.${NORM}"
  exit 0
fi

build_info "Building dwm..."
if ! $(${CC} ${CFLAGS} ${LIBS} -o ${BIN}/${OUT} unity.c); then
  echo -e "${RED}[ERROR]${NORM} Couldn't build dwm."
  exit 1
fi

build_info "Stripping dwm..."
strip ${BIN}/${OUT}
build_info "${GREEN}Done.${NORM}"

