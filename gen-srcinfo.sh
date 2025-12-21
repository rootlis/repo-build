#!/bin/bash
set -euo pipefail

if [ $# -eq 0 ]; then
	echo >&2 "Generate .SRCINFO files for one or more PKGBUILDs. Output placed in PKGBUILD's directory."
	echo >&2 "usage: $0 <PKGBUILD> [<PKGBUILD> ...]"
	exit 1
fi

while [ $# -gt 0 ]; do
	pb=$(readlink -e "$1")
	pbdir=$(dirname "$pb")
	pushd "$pbdir" >/dev/null
	printf >&2 'Generating .SRCINFO in %s...' "$pbdir"
	makepkg --printsrcinfo >.SRCINFO
	printf >&2 " done.\n"
	popd >/dev/null
	shift
done
