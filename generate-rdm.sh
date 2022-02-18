#!/bin/bash

set -xeuo pipefail

tfdocsversion="0.15.0"
tfdocsconfigdir="$(realpath $(dirname $0))"

if [[ ! -d "examples" ]]
then
  docker run -v `pwd`:`pwd` -w `pwd` --rm --name tfdocs quay.io/terraform-docs/terraform-docs:${tfdocsversion} markdown . --hide requirements --anchor=false --output-file README.md --lockfile=false
else
  docker run -v ${tfdocsconfigdir}:${tfdocsconfigdir} -v `pwd`:`pwd` -w `pwd` --rm --name tfdocs quay.io/terraform-docs/terraform-docs:${tfdocsversion} markdown . --hide requirements --anchor=false --output-file README.md --lockfile=false -c ${tfdocsconfigdir}/terraform-docs.yml
fi
