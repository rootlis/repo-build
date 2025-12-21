#!/bin/bash
set -euo pipefail
SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

if [ "$#" -ne 1 ]
then
	echo >&2 "Search a directory tree for .SRCINFO files and generate a list of dependency pairs."
	echo >&2 "usage: $0 <pkgbuild repo dir>"
	exit 1
fi
searchpath=$(readlink -e "$1")

mapfile -d '' files < <(find "$searchpath" -maxdepth 2 -name '.SRCINFO' -print0)
"${SCRIPT_DIR}/srcinfo2edges.awk" "${files[@]}"
