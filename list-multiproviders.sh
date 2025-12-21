#!/bin/sh
# Read .SRCINFOs to find pkgnames/provides satisfied by multiple PKGBUILDs.
# These package relationships create dependency cycles that could be resolved by
# a SAT solver.
#
# Run from top level of your ABS tree.

find . -name .SRCINFO -exec \
	sh -c './srcinfo2edges.sh '{} \; \
| awk '$1 ~ /^\// { print $2 }' \
| sort \
| uniq --repeated
