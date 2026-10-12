#!/bin/bash
set -eu

# repo_pkglist <repo>: Print each pkgname in repo
repo_pkglist() { (
	dbscripts_dir="$(dirname "$(readlink -e "$(which db-move)")")"
	. "${dbscripts_dir}/config"
	for a in "${ARCHES[@]}"; do
		db="${FTP_BASE}/$1/os/$a/$1${DBEXT}"
		bsdtar xOf "$db" '*/desc' \
		| awk '/^%NAME%$/ { getline; print }'
	done
) }

[ "$#" -ne 2 ] && echo >&2 "usage: $0 <repo-from> <repo-to>" && exit 1
from="$1"; to="$2"

set -- $(repo_pkglist "$from")
exec db-move "$from" "$to" "$@"
