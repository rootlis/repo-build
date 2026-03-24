#!/bin/sh
set -euo pipefail

# Consider locking dbscripts before snapshotting.

if [ $# -eq 0 ]; then
	echo >&2 "List differences between snapshot and current state"
	echo >&2 "usage: $0 <parent dataset>"
	exit 255
fi
parent_dataset="$1"

while read -r snapshot;
do
	zfs diff -Ft "$snapshot" | awk -v OFS=$'\t' -v snapshot="$snapshot" '{
		$1=strftime("%Y/%m/%d %T",$1); print $0, snapshot;
	}'
done < <(
	zfs list -r -H -t snapshot -s creation -o name "$parent_dataset" \
	| awk -v parent="$parent_dataset" -F@ '
	{last[$1]=$0}
	END {delete last[parent]; for (ds in last) print last[ds]}'
)
