#!/bin/sh
set -euo pipefail
SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

if [ $# -ne 1 ]; then
	echo >&2 "Scan a directory for PKGBUILDs, calculate build order, and build all of them."
	echo >&2 "usage: $0 <pkgbuild repo>"
	exit -1
fi

if ! pkgbuild_repo=$(readlink -e "$1"); then
	echo >&2 "Can't find pkgbuild directory: $3"
	exit 3
fi

mapfile -t pkgbuilds < <("${SCRIPT_DIR}/repo2edges.sh" "$pkgbuild_repo" | tsort | grep "$pkgbuild_repo")
"${SCRIPT_DIR}/build-some.sh" "${pkgbuilds[@]}"

exit 0
