#!/bin/bash
set -euo pipefail

repo=pacbrew-staging
commitmsg="bootstrap repo"

# pkgctl options:
# --repo
# 	Specify the target repository name. Pkgctl uses the repo name to pick
# 	the right pacman.conf and makepkg.conf. While it can auto-detect the
# 	right repo by checking the Pacman sync DB, it checks only repos listed
# 	in /usr/share/devtools/pacman.conf.d/multilib.conf, meaning custom
# 	repos are excluded.
#
# -r	Release package
# 	1. Generate new .SRCINFO.
# 	2. Verify all validpgpkeys in PKGBUILD are in ./keys/pgp directory.
# 	   Export them to ./keys/pgp/$key.asc if not. Fail if you can't export.
# 	3. Add required files to package source control:
# 		* license files (using pkgctl license check)
# 		* PKGBUILD
# 		* source files shipped with the PKGBUILD, e.g. patches
# 		* install scripts
# 		* changelogs
# 		* PGP keys
# 		* .SRCINFO
# 	4. Commit changes to these files.
# 	5. Sign built package file.
# 	6. Rsync package & .sig file to package server at
# 	   $PACKAGING_REPO_RELEASE_HOST:staging/$repo. You can specify a
# 	   different server by exporting PACKAGING_REPO_RELEASE_HOST.
#
# -m	Specify the commit message applied during the release step. Pkgctl will
# 	prompt the user for a commit message if this option is omitted.
#
# -u	Run db-update on $PACKAGING_REPO_RELEASE_HOST over SSH to publish the
# 	uploaded package to the package sync database.

pkgctl build --repo $repo -r -m "$commitmsg" -u "$@"
