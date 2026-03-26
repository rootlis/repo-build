#!/bin/sh
set -euo pipefail
SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

# A wrapper for the edge2makefile.awk pipeline:
# Generate a Makefile to determine build order for one or more target packages.
# Usage:
# 	1. Set pbdir to the directory containing the repository's PKGBUILDs.
# 	2. make -rR -f Buildorder.mk -j1 <pkgname> [pkgname ...] | grep '^/'
# Delete Makefile in this script's directory to regenerate rules

if [ $# -lt 2 ];
then
	echo >&2 "Print the build order for one or more targets in a PKGBUILD repo as a list of PKGBUILD paths."
	echo >&2 "usage: $0 <pkgbuild repo root> <pkgname> [pkgname ...]"
	exit 1
fi
pbroot=$1
mkfile="${pbroot}/Buildorder.mk"
shift

cd "$SCRIPT_DIR"
[ -e "$mkfile" ] || ./repo2edges.sh "$pbroot" | ./edge2makefile.awk > "$mkfile"
cd "$pbroot"
make -B -rR -f "$mkfile" -j1 "$@" | grep '^/'
