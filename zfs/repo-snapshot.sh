#!/bin/sh
set -euo pipefail

# Consider locking dbscripts before snapshotting.

if [ $# -eq 0 ]; then
	echo >&2 "Snapshot binary/source repos."
	echo >&2 "usage: $0 <parent dataset>"
	exit 255
fi
parent_dataset="$1"
bin_dataset="$parent_dataset"/binary-repo
state_dataset="$bin_dataset"/state
src_dataset="$parent_dataset"/source-repo

bin_mountpoint=$(zfs get -H -o value mountpoint "$bin_dataset")
state_mountpoint=$(zfs get -H -o value mountpoint "$state_dataset")
src_mountpoint=$(zfs get -H -o value mountpoint "$src_dataset")

read -r lastupdate < "$bin_mountpoint"/lastupdate
state_commit=$(
	git -C "$state_mountpoint"/state rev-parse --short --verify HEAD \
	|| echo INVALID
)
src_dirty=$(
	[ -n "$(git --no-optional-locks -C "$src_mountpoint" status --porcelain)" ] \
	&& echo true \
	|| echo false
)
src_commit=$(
	git -C "$src_mountpoint" rev-parse --short --verify HEAD \
	|| echo INVALID
)
src_branch=$(git -C "$src_mountpoint" symbolic-ref --quiet --short HEAD \
	|| echo DETACHED
)

snapname=repo-snapshot-"$(date -Im)"
zfs snapshot -r \
	-o net.rootless:bin-lastupdate="$lastupdate" \
	-o net.rootless:state-git-commit="$state_commit" \
	-o net.rootless:source-git-commit="$src_commit" \
	-o net.rootless:source-git-branch="$src_branch" \
	-o net.rootless:source-git-dirty="$src_dirty" \
	"${parent_dataset}@${snapname}"
