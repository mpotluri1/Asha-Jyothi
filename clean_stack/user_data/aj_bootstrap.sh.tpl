#!/bin/bash
( set -x
sudo apt-get -y update
) 2>&1 | tee /tmp/aj-bootstrap.log