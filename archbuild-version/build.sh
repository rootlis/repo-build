#!/bin/bash
set -euo pipefail
arch=x86_64
repobase=/srv/alpm
reponame=pacbrew-staging

repodir="${repobase}/${reponame}/${arch}"
db="${repodir}/${reponame}.db.tar.gz"
buildcmd="${reponame}-${arch}-build"
makepkgconf="/usr/share/devtools/makepkg.conf.d/${reponame}-${arch}.conf"

check_update() {
	# Download source, update pkgver, then check if we need a rebuild
	makepkg --noprepare --nodeps --nobuild --config "${makepkgconf}"
	read pkgname newver < <(makepkg --printsrcinfo | awk '
		/pkgbase/ { b = $3    }
		/epoch/   { e = $3":" }
		/pkgver/  { v = $3    }
		/pkgrel/  { r = "-"$3 }
		/pkgname/ { printf "%s %s%s%s\n", $3, e,v,r; exit }
	')
	read oldver < <(bsdtar -xOzf "$db" | awk -v "name=${pkgname}" '
		BEGIN                        { RS="\n\n"; FS="\n" }
		$1 ~ /%NAME%/    && $2==name { nameflag=1; }
		$1 ~ /%VERSION%/ && nameflag { nameflag=0; print v=$2 }
		END                          { exit !v }
	') && case $(vercmp $newver $oldver) in
		-1) echo >&2 "Source PKGBUILD outdated" ; exit 3;;
		 0) echo >&2 "Repository up-to-date"    ; exit 0;;
		 1) ;;
	esac
	echo >&2 "Package update available"
}

FORCE_REBUILD=0
for a in "$@"; do
	[ "$a" = -f ] && FORCE_REBUILD=1 && break
done
[[ ! $FORCE_REBUILD = 1 ]] && check_update $db

# Build
"${buildcmd}" "$@"

# Push to repo: copy & update database
mapfile -t pkglist < <(makepkg --packagelist --config "${makepkgconf}")
mapfile -t copied < <(sudo rsync -ptgo --out-format="${repodir}/%n" \
	-- "${pkglist[@]}" "${repodir}/"
)
(( ${#copied[@]} )) && sudo repo-add -R "$db" "${copied[@]}"
