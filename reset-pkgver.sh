#!/bin/sh

if [ "$#" -eq 0 ]; then
	echo >&2 "usage: $0 <PKGBUILD> [<PKGBUILD> ...]"
	exit 1
fi
sed -i 's/\(^pkgver=\).*/\1git/' "$@"
