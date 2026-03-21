repo-build contents
2025-08-19
2025-12-18 - Add pkgctl version

.SRCINFO Dependency Analysis 
buildorder.sh			Input: pkgnames 	/ Stdout: PKGBUILD files to build specified pkgnames in order
repo2edges.sh			Input: ABS tree 	/ Stdout: tab-separated dependency pairs
list-multiproviders.sh		Input: ABS tree		/ Stdout: pkgnames provided by multiple PKGBUILDs

PKGBUILD Repository Info
list-all-makedepends.sh		Input: ABS tree		/ Stdout: pkgbase<tab>build_dep1 build_dep2 ...
list-pkgbuild-options.sh	Input: ABS tree 	/ Stdout: pkgbase<tab>opt1 opt2 ...

PKGBUILD Repository Updating
gen-srcinfo.sh			Input: PKGBUILDs	/ Result: Writes .SRCINFO files in place
run-pkgver.sh			Input: PKGBUILDs	/ Result: Runs pkgver() on PKGBUILDs
reset-pkgver.sh			Input: PKGBUILDs	/ Result: Sets pkgver to git

Awk Scripts
srcinfo2edges.awk		Input: .SRCINFOs	/ Stdout: tab-separated dependency pairs (edges)
edge2dot.awk			Stdin: edges		/ Stdout: Graphviz DOT file
edge2makefile.awk		Stdin: edges		/ Stdout: Makefile for buildorder.sh

archbuild-version/
build.sh			Run pkgver(), compare pkgver with repo, archbuild, and push to repo.
build-some.sh			Input: PKGBUILDs	/ Result: Runs build.sh for each PKGBUILD
build-all.sh			Input: ABS tree		/ Result: Runs build.sh for all PKGBUILDs
repo-init.sh			Input: dest, arch, EXT	/ Result: Creates empty .db.tar.gz files in dest/arch/
usr/				Config files to copy to devtools installation

pkgctl-version/
build.sh			Build, commit package source changes, and push to repo.
build-some.sh			Input: PKGBUILDs	/ Result: Runs build.sh for each PKGBUILD
build-all.sh			Input: ABS tree		/ Result: Runs build.sh for all PKGBUILDs in proper order
reset-repo.sh			Input: repo name	/ Result: Deletes pkgs from dbscripts, pacman cache, & ~/staging

---
Using pkgctl version

How to bootstrap a local binary repo from pacbrew-repo
- Clone pacbrew-repo
	$ git clone git@github.com:rootlis/pacbrew-repo.git
- Initialize package source repo
	$ cd pacbrew-repo
	$ pkgctl repo configure
	# Remove a default rule that works only for single-package source repos.
	$ sed -i '/^\/\*\/$/d' .git/info/exclude
- Build
	$ ../repo-build/pkgctl-version/build-all.sh .

How to handle a new package
- Build it and push it to staging repo
	$ pkgctl build --repo pacbrew-staging -r -m "blah" -u

How to handle one updated package
- Build it and push it to staging repo
	$ pkgctl build --repo pacbrew-staging -r -m "blah" -u
- Find its reverse dependencies & build order
	$ arch-rebuild-order --repos=pacbrew,pacbrew-testing,pacbrew-staging <pkgname>
- Rebuild them and push to staging repo
	$ pkgctl build --rebuild --repo pacbrew-staging -r -m "Rebuild for <pkgname>"

How to handle multiple updated packages
- Find the reverse dependencies & build order
	$ arch-rebuild-order --repos=pacbrew,pacbrew-testing,pacbrew-staging <pkgname1> <pkgname2>...
- Using that build order, build packages that were updated, and rebuild packages that weren't.

** If we do --rebuild for updated packages, will they decline to increment pkgrel?

---
Setting up pkgctl version (Steps may be incomplete & require testing)

How to prepare build machine
- Set up makepkg
	Set PACKAGER and GPGKEY in ~/.config/pacman/makepkg.conf
	$ echo >>~/.config/pacman/makepkg.conf PACKAGER="Your Name <youremail@example.com>"
	$ echo >>~/.config/pacman/makepkg.conf GPGKEY="YOURPUBLICKEY"
	Let gpg cache your PIN
	$ echo >>~/.gnupg/gpg-agent.conf "pinentry-program /usr/bin/pinentry-tty"
	$ echo >>~/.gnupg/gpg-agent.conf "default-cache-ttl 7200"
	$ echo >>~/.gnupg/gpg-agent.conf "max-cache-ttl 86400"
- Uninstall official devtools
	# pacman -R devtools
- Install my devtools fork (includes makepkg/pacman configs & configured Makefile)
	$ cd devtools
	$ git switch pacbrew
	$ make clean && make && sudo make install

How to prepare packaging server
- Log into packaging server
	$ ssh example.com
- Install my dbscripts fork (including config.local)
	$ cd dbscripts
	$ git switch pacbrew
	# ln -sf db-archive db-move db-remove db-repo-add db-repo-remove db-update testing2x cron-jobs/
	# find . -maxdepth 2 -type f -executable -exec ln -sf "{}" /usr/local/bin/ \;
- Create archive user and packager group
	# groupadd packager
	# echo '%packager ALL = (archive) NOPASSWD: /usr/local/bin/db-archive' > /etc/sudoers.d/dbscripts
	# useradd -M archive
	# mkdir -p /srv/archive
	# chown archive:archive /srv/archive
- Set up directory tree
	# echo 0 >/srv/ftp/lastupdate
	# mkdir -p \
		/srv/repos/state \
		/srv/ftp/pool/packages{,-debug} \
		/srv/ftp/pacbrew{,-testing,-staging}/os/x86_64
	# chgrp packager \
		/srv/ftp/lastupdate \
		/srv/repos/state \
		/srv/ftp/pool/packages{,-debug} \
		/srv/ftp/pacbrew{,-testing,-staging}/os/x86_64
	# chmod 775 \
		/srv/ftp/lastupdate \
		/srv/repos/state \
		/srv/ftp/pool/packages{,-debug} \
		/srv/ftp/pacbrew{,-testing,-staging}/os/x86_64
	$ git -C /srv/repos/state init --initial-branch=main --shared=group .
- Configure your user
	$ mkdir ~/staging
	# usermod -a -G packager yourusername
	# mkdir -p /etc/dbscripts
	# echo "Your Name <youremail@example.com> yourusername" >> /etc/dbscripts/authors.conf

How to add a custom repository to devtools via Makefile
- Add "myrepopkg" "myrepo-testingpkg" and "myrepo-stagingpkg" to COMMITPKG_LINKS
- Add "myrepo-x86_64-build" "myrepo-testing-x86_64-build" and "myrepo-staging-x86_64-build" to ARCHBUILD_LINKS

How to add a custom repository to dbscripts via config.local
- Create ACL_MYREPO_ALL array
	ACL_MYREPO_ALL=( \
		myrepo myrepo-debug \
		myrepo-testing myrepo-testing-debug \
		myrepo-staging myrepo-staging-debug)
- Add ACL_MYREPO_ALL to ACL array
	ACL=( [packager]="... ${ACL_MYREPO_ALL[@]}" )
- Add repos to PKGREPOS, DEBUGREPOS, STABLE_REPOS, TESTING_REPOS, & STAGING_REPOS
	PKGREPOS=(... myrepo myrepo-staging myrepo-testing)
	STABLE_REPOS=(... myrepo)
	TESTING_REPOS=(... myrepo-testing)
	STAGING_REPOS=(... myrepo-staging)

---
Using Archbuild version

* How to install build tools
- Install official devtools
	# pacman -S devtools
- Generate a pacman.conf
	Append [prosperobrew-staging] section to /usr/share/devtools/pacman.conf.d/extra-x86_64.conf
- Copy makepkg & pacman configs to devtools
	# install pacbrew-repo/makepkg.conf /usr/share/devtools/makepkg.conf.d/prosperobrew-staging-x86_64.conf
	# install pacman.conf               /usr/share/devtools/pacman.conf.d/prosperobrew-staging.conf
- Symlink /usr/bin/prosperobrew-staging-x86_64-build to /usr/bin/archbuild
	# ln -s /usr/bin/archbuild /usr/bin/prosperobrew-staging-x86_64-build

* How to bootstrap a local binary repo from pacbrew-repo
- Initialize binary repo
	# repo-init.sh /srv/alpm/prosperobrew-staging x86_64
- Clone pacbrew-repo
	$ git clone git@github.com:rootlis/pacbrew-repo.git
- Configure pacbrew-repo/build.sh: Set variables
	arch=x86_64
	repobase=/srv/alpm
	reponame=prosperobrew-staging
- Generate .SRCINFOs
	$ gen-srcinfo.sh pacbrew-repo/*/PKGBUILD
- Build each PKGBUILD and push to binary repo
	$ build-all.sh pacbrew-repo

* How specify a single target when bootstrapping a local binary repo
* How to add a new binary to the repo
* How to update a binary with a git-based PKGBUILD
- Don't forget to rebuild its dependents
