#!/bin/awk -f
# Generate a GraphViz DOT file from the output of repo2edges.sh

BEGIN {
	FS="$'\t'"
	print "digraph G {"
	print "  rankdir=LR; graph [overlap=false, splines=true];"
	print "  node [fontsize=10];"
}

function esc(s) { gsub(/["\\]/, "\\\\&", s); return "\"" s "\"" }

# classify endpoints (heuristic: path vs package token)
{
	from=$1; to=$2
	isDirFrom = (from ~ /^\.{0,2}\// || from ~ /^\//)
	isDirTo   = (to   ~ /^\.{0,2}\// || to   ~ /^\//)

	# node appearance
	if (isDirFrom  && !seen[from]++) printf "  %s [shape=box];\n",     esc(from)
	if (!isDirFrom && !seen[from]++) printf "  %s [shape=ellipse];\n", esc(from)
	if (isDirTo    && !seen[to]++  ) printf "  %s [shape=box];\n",     esc(to)
	if (!isDirTo   && !seen[to]++  ) printf "  %s [shape=ellipse];\n", esc(to)

	# edge style: dashed for dir->pkg (provides), solid otherwise (depends)
	style = (isDirFrom && !isDirTo) ? "dashed" : "solid"
	printf "  %s -> %s [style=%s];\n", esc(from), esc(to), style
}

END { print "}" }
