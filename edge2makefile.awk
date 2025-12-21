#!/bin/awk -f
# Generate a Makefile to determine build order for one or more target packages.
# Usage:
# 	1. Pipe repo2edges.sh into this script.
# 	2. Redirect output into a Makefile.
# 	3. make -rR -f <Makefile> -j1 <target> | grep '^/'

BEGIN { FS="\t"; OFS="" }
{
	dep[$2] = dep[$2] " " $1
	seen[$1]=1; seen[$2]=1
}
END {
	print ".PHONY: all"
	printf "all:"
	for (n in seen) {
		printf " %s", n
	}
	print "\n"

	for (n in seen) {
		printf "%s:%s\n", n, dep[n]
		printf "\t@echo %s\n\n", n
	}
}
