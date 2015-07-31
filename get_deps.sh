#!/bin/bash

#Script that lists dependencies of all packages in cdh and cm

set -ex

REPO=http://archive.cloudera.com
VERSION=5.4.0

#Should be the major version
REDHAT_VERSION=6

for artifact in cdh cm
do
  rm -rf $artifact
  mkdir -p $artifact
  for arch in x86_64 noarch
  do
    (cd $artifact ; wget -r --no-directories --level=2 $REPO/${artifact}5/redhat/$REDHAT_VERSION/x86_64/$artifact/$VERSION/RPMS/$arch -A \*.rpm)
  done
  (cd $artifact ; rpm -qpR *.rpm | sort -u > ${artifact}.deps)
done

