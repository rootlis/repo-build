#!/bin/bash
set -euo pipefail

CACHE="/var/cache/pacman/pkg"

if [ "$#" -lt 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
	echo "Delete package files from repo, cache, & your staging area"
	echo "usage: $0 <repo-name>"
	exit 1
fi

while [ "$#" -gt 0 ]; do
	repo="$1"
	shift

	rm -rf "${HOME}/staging/${repo:?}"

	while IFS= read -r -d '' pkgname; do
		db-remove "$repo" "$pkgname"
		sudo rm -f "$CACHE/${pkgname}-"*"-"*"-"*".pkg.tar."*
	done < <(
		bsdtar xOf "/srv/ftp/${repo}/os"/*/"${repo}.db.tar.gz" \
		| awk '$0=="%NAME%" {getline; printf "%s\0",$0}'
	)
done
ftpdir-cleanup
