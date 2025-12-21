#!/bin/sh
set -euo pipefail

if [ "$#" -ne 4 ]; then
        echo "usage: $0 <chroot dir> <pkg repo dir> <pkgbuild repo dir> <pkg>" >&2
        exit 1
fi
chrootdir=$(readlink -f "$1")
pkgdir=$(readlink -f "$2")
pbdir=$(readlink -f "$3")
pkg=$4

reponame=$(basename "$pkgdir")
db="${pkgdir}/${reponame}.db.tar.gz"

export PKGDEST="$pkgdir"
export MAKEFLAGS="-j$(( $(nproc)+1 ))"

cd "$pbdir/$pkg"
# makechrootpkg options
# -C	Run checkpkg on the build package
# -c	Clean the chroot before building
# -D	Bind directory into build chroot as read-only
# -d	Bind directory into build chroot as read-write
# -n	Run namcap on the build package
# -r	(required) Chroot directory
# -T	Build in a temporary directory
# -u	Update the working copy of the chroot before building
# -x	Inspect chroot after build. Options: never (default), always, failure
makechrootpkg -x failure -T -c -d "$pkgdir" -r "$chrootdir"
pkglist=($(makepkg --config ${pbdir}/makepkg.conf --packagelist))

# repo-add options
# -n	Only add packages that are not already in the database
# -R	Remove old package files from the disk when updating their entry
repo-add -nR "$db" ${pkglist[@]}
