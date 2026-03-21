#!/bin/bash
set -euo pipefail
SCRIPT_PATH=$(readlink -e "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

repo=pacbrew-staging
universe=pacbrew,pacbrew-testing,pacbrew-staging

if '[' $# -lt 1 ']'; then
	echo >&2 "Upgrade a package and rebuild its reverse dependencies."
	echo >&2 "usage: $0 <pkgbuild dir>"
	exit 255
fi

srcdir="$1"
repodir="$(dirname "$srcdir")"

pkgctl build --repo $repo -r -u "$srcdir"

mapfile -t pkgnames < <(awk '/^pkgname = / { print $3 }' "${srcdir}/.SRCINFO")
read -r pkgver      < <(awk '/pkgver = /  { print $3 }'  "${srcdir}/.SRCINFO")

mapfile -t -d ' ' -s 1 revdeps < <(arch-rebuild-order --repos="$universe" "${pkgnames[@]}")
mapfile -t buildme < <(
	expac -S '%e' "${revdeps[@]}" \
	| awk -v repodir="$repodir" '!seen[$0]++ {
		sub(/^ps5-payload-/, "")
		printf("%s/%s\n", repodir, $0)
	}' 
)

declare -a skipped
for p in "${buildme[@]}"
do
	pkgctl build --rebuild \
		--repo $repo \
		-r -m "Rebuild for ${pkgnames[@]}" \
		-u \
		"$p" \
	|| skipped+=("$p")
	break
done

[ "${#skipped}" -eq 0 ] && exit 0

echo >&2 "Skipped the following packages:"
for pkg in "${skipped[@]}"; do
	echo >&2 "$pkg"
done
exit 0
