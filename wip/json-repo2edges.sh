#!/bin/sh

# Alternative dependency lister using alpm-srcinfo and jq.
# Neat, but way harder to understand than the awk version.

set -euo pipefail
SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

if [ "$#" -ne 1 ]
then
	echo >&2 "Search directory for .SRCINFO files and generate a list of dependency:target pairs."
	echo >&2 "usage: $0 <pkgbuild repo dir>"
	exit 1
fi

while IFS= read -r -d '' f
do
	srcinfo=$(readlink -f "$f")
	pkgbuild=$(dirname "$srcinfo")/PKGBUILD

	alpm-srcinfo format -o json "$srcinfo" \
	| jq --raw-output --arg pkgbuild "$pkgbuild" '
	(
		[
			[
				.base
				| .make_dependencies, .dependencies
				| .[]
				| .name, .Basic
				| strings
			],
			[$pkgbuild]
		] | combinations
	),
	(
		[
			[$pkgbuild],
			[
				.packages
				| .[]
				| .name , (
					.provides
					| .value
					| arrays
					| .[]
					| .name, .Basic
					| strings
				)
			] | unique
		] | combinations
	)
	| join("\t")

	'
done < <(find "$1" -name .SRCINFO -print0)
