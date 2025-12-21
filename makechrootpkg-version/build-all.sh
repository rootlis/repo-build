#!/bin/sh
set -euo pipefail
SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

if [ $# -ne 3 ]; then
	echo >&2 "Scan a directory for PKGBUILDs, calculate build order, and build all of them."
	echo >&2 "usage: $0 <chroot dir> <pkg repo> <pkgbuild repo>"
	exit -1
fi

if ! chrootdir=$(readlink -f "$1"); then
	echo >&2 "Can't find chroot directory: $1"
	exit 1
fi

if ! pkg_repo=$(readlink -f "$2"); then
	echo >&2 "Can't find pkg repo directory: $2"
	exit 2
fi

if ! pkgbuild_repo=$(readlink -f "$3"); then
	echo >&2 "Can't find pkgbuild directory: $3"
	exit 3
fi

skipped=()
pkgbuilds=$(./repo2edges-awk.sh "$pkgbuild_repo" | tsort | grep "$pkgbuild_repo")
for p in ${pkgbuilds[@]}; do
	pkg=$(basename "$p")
	${SCRIPT_DIR}/build.sh "$chrootdir" "$pkg_repo" "$pkgbuild_repo" $pkg \
	|| skipped+=($pkg)
done

[ ${#skipped} -eq 0 ] && exit 0

echo >&2 "Skipped the following packages:"
for pkg in ${skipped[@]}; do
	echo >&2 $pkg
done
exit 1
