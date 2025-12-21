#!/bin/awk -f
# A work-in-progress solution to parallelized repo rebuilds.
#
# Generate a makefile to build one or more targets in parallel.
# Run script inside pacbrew-repo dir.
# How the makefile should look:
# 	ps5-payload-eduke32.<ver>-x86_64.tar.gz:
# 		cd eduke32
# 		prosperobrew-staging-x86_64
# 		mv ps5-payload-eduke32.<ver>-x86_64.tar.gz 
# What about where the packages are put?

BEGIN { OFS="" }
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
