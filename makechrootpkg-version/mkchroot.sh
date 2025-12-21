#!/bin/sh
set -euo pipefail

EXT=tar.gz

if [ "$#" -ne 4 ]
then
	echo >&2 "Create a clean chroot for package building"
	echo >&2 "usage: $0 <pacman.conf> <makepkg.conf> <repo dir> <chroot dir>"
	exit 1
fi
pacmanconf=$(readlink -f "$1")
makepkgconf=$(readlink -f "$2")
repodir=$(readlink -f "$3")
chrootdir=$(readlink -f "$4")

reponame=$(basename "$repodir")
files="${repodir}/${reponame}.files.${EXT}"
db="${repodir}/${reponame}.db.${EXT}"

if echo $repodir | grep -q ' '
then
	echo >&2 "Repository path cannot have spaces: \"${repodir}\""
	exit 7
fi

# Verify pacman.conf exists
if [ ! -e "$pacmanconf" ]
then
	echo >&2 "Invalid pacman.conf"
	exit 1
fi

# Verify makepkg.conf exists
if [ ! -e "$makepkgconf" ]
then
	echo >&2 "Invalid makepkg.conf"
	exit 2
fi

# Verify repo exists.
if [ ! -e "$db" ] || [ ! -e "$files" ]
then
	echo >&2 "Repository not initialized."
	exit 3
fi

# Verify repo can be written to.
if ! repo-add "$db" 1>/dev/null 2>/dev/null
then
	echo >&2 "Failed to access existing repository at $files and $db."
	exit 4
fi

# Create chroot directory.
if ! mkdir "$chrootdir"
then
	echo >&2 "Failed to create chroot directory."
	exit 5
fi

# Append target repository to pacman.conf
tmp=$(mktemp); trap 'rm -f "'$tmp'"' EXIT
cp "$pacmanconf" "$tmp"
cat >>"$tmp" <<-EOF
	[${reponame}]
	SigLevel = Optional TrustAll
	Server = file://${repodir}
EOF

cat "$tmp"
if ! mkarchroot -C "${tmp}" -M "$makepkgconf" "${chrootdir}/root" base-devel
then
	echo >&2 "Failed to create chroot."
	rmdir "${chrootdir}"
	exit 6
fi
