#!/bin/bash
set -euo pipefail
arch=x86_64
reponame=prosperobrew-staging

if [ $# -eq 0 ]; then
	echo >&2 'Download source and run pkgver() for one or more PKGBUILDs.'\
		 'Clobbers existing source. Set arch/reponame in script file.'
	echo >&2 "usage: $0 <PKGBUILD> [<PKGBUILD> ...]"
	exit 1
fi

makepkgconf="/usr/share/devtools/makepkg.conf.d/${reponame}-${arch}.conf"
while [ $# -gt 0 ]; do
	echo >&2 "Downloading source and updating pkgver at $1"
	pb=$(readlink -e "$1")
	pbdir=$(dirname "$pb")
	pushd "$pbdir" >/dev/null
	makepkg --clean --cleanbuild \
		--config "${makepkgconf}" \
		--nodeps \
		--nocolor \
		--nobuild \
		--noprepare
	popd >/dev/null
	shift
done
