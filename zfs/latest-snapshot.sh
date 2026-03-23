#!/bin/sh
set -euo pipefail

if [ $# -eq 0 ]; then
	echo >&2 "List a dataset's latest snapshot name recursively."
	echo >&2 "usage: $0 <dataset>"
	exit 255
fi
dataset="$1"

echo "Dataset	Snapshot	bin-lastupdate	state-git-commit	source-git-dirty	source-git-commit	source-git-branch"
zfs list -H -t snapshot -s creation -r \
	-o name,net.rootless:bin-lastupdate,net.rootless:state-git-commit,net.rootless:source-git-dirty,net.rootless:source-git-commit,net.rootless:source-git-branch \
	"$dataset" \
| awk -F@ '{last[$1]=$0} END {for (ds in last) print last[ds]}' \
| sed 's/\@/\t/'
