#!/bin/bash -e

cd /domjudge-src/domjudge*
sudo -u domjudge ./configure -with-baseurl=http://localhost/
sudo -u domjudge make domserver
make install-domserver