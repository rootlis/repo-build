#!/usr/bin/env bash
set -euo pipefail
EXT=tar.gz

if [ "$#" -ne 2 ]; then
	echo >&2 "Initialize an empty ALPM repository directory."
	echo >&2 "usage: $0 <repo base dir> <arch>"
	echo >&2 "	e.g. $0 /srv/myrepo x86_64"
	exit 255
fi

repobase=$(readlink -m "$1")
repodir=$(readlink -m "${repobase}/${2}")
reponame=$(basename "$repobase")
db="${repodir}/${reponame}.db.${EXT}"

if [ -e "$db" ]; then
	echo >&2 "Repository database already exists at ${db}"
	exit 1
fi

mkdir -p "$repodir"
if ! repo-add --quiet "$db"; then
	echo >&2 "Repository initialization failed."
	exit 2
fi
echo >&2 "Repository initialized at ${db}."
