#!/bin/bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
	echo "Reset source repo."
	echo "usage: $0 <repo-path>"
	exit 1
fi
repodir="$1"

# repo-rinse.sh: https://gist.github.com/nicktoumpelis/11214362
git -C "$repodir" reset --hard
git -C "$repodir" submodule sync --recursive
git -C "$repodir" submodule update --init --force --recursive
git -C "$repodir" clean -iffdx
git -C "$repodir" submodule foreach --recursive git clean -iffdx

git -C "$repodir" status
