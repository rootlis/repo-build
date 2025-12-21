#!/usr/bin/env bash
set -euo pipefail

EXT=tar.gz
if [ "$#" -ne 1 ]; then
	echo >&2 "Create an empty ALPM repository. Directory must not exist."
	echo >&2 "usage: $0 <repo dir>"
	exit 1
fi
repodir=$(readlink -f "$1")
reponame=$(basename "$repodir")
db="${repodir}/${reponame}.db.${EXT}"

if ! mkdir "$repodir"; then
	echo >&2 "Couldn't create repository directory."
	exit 2
fi
if ! repo-add --quiet "$db"; then
	echo >&2 "Repository initialization failed."
	rmdir "$repodir"
	exit 3
fi
echo Repository initialized.
