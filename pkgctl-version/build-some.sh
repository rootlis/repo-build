#!/bin/bash
set -euo pipefail
SCRIPT_PATH=$(readlink -e "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

if [ $# -lt 1 ]; then
	echo >&2 "Rebuild PKGBUILDs"
	echo >&2 "usage: $0 <PKGBUILD dir> [<PKGBUILD dir> ...]"
	exit 255
fi

echo "$1"
skipped=()
while [ $# -gt 0 ]
do
	pushd "$1"
	"${SCRIPT_DIR}/build.sh" -- -- -f || skipped+=("$1")
	popd
	shift
done

[ "${#skipped}" -eq 0 ] && exit 0

echo >&2 "Skipped the following packages:"
for pkg in "${skipped[@]}"; do
	echo >&2 "$pkg"
done
exit 0
