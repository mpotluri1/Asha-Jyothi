#!/bin/bash
( set -x
sudo yum -y update &
sudo yum -y install git
) 2>&1 | tee /tmp/aj-bootstrap.log