#!/bin/awk -f

# List package build dependency relationships from .SRCINFO files as tab-
# separated pairs. Pass each .SRCINFO as an argument. Assumes the .SRCINFO and
# its PKGBUILD are in the same directory.
#
# Example usage
# ./srcinfo2edges.awk core/gzip/.SRCINFO
# ./srcinfo2edges.awk {core,extra}/*/.SRCINFO
#
# Example output
# dep1	path/to/PKGBUILD
# dep2	path/to/PKGBUILD
# dep3	path/to/PKGBUILD
# path/to/PKGBUILD	pkgname1
# path/to/PKGBUILD	pkgname2
# path/to/PKGBUILD	provides1
# path/to/PKGBUILD	provides2

BEGIN { OFS="\t" }

# New file: Print previous file and re-initialize.
$1 == "pkgbase" {
	for (d in deps)  { print d, pkgbuild; delete deps[d]  }
	for (n in names) { print pkgbuild, n; delete names[n] }
	pkgbuild = FILENAME
	sub(/\.SRCINFO$/, "PKGBUILD", pkgbuild)
}

$1 == "pkgbase" 			{ base     = 1 }
$1 == "depends"	     && $3 && base	{ deps[$3] = 1 }
$1 == "makedepends"  && $3 && base	{ deps[$3] = 1 }
$1 == "checkdepends" && $3 && base	{ deps[$3] = 1 }
NF == 0					{ base      = 0 }
$1 == "pkgname"     && $3		{ names[$3] = 1 }
$1 == "provides"    && $3		{ names[$3] = 1 }

# Print the final file.
END {
	for (d in deps)  print d, pkgbuild
	for (n in names) print pkgbuild, n
}
