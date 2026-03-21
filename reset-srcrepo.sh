#!/bin/bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
	echo "Reset source repo."
	echo "usage: $0 <repo-path>"
	exit 1
fi
repodir="$1"

git -C "$repodir" clean -fiXd
git -C "$repodir" reset :/
git -C "$repodir" restore :/
git -C "$repodir" status
