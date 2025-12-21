#!/bin/bash
# List the options set for each package. Run from top level of your ABS tree.

find . -name 'PKGBUILD' -execdir sh -c 'printf "$(basename $(pwd))        "; source {}; echo $options' \; | column -t
