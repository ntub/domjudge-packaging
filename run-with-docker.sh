#!/bin/bash
set -e

./scripts/create-db.sh
./scripts/create-domserver.sh
./scripts/create-judgehost.sh
./scripts/create-reverse-proxy.sh
./scripts/get-info.sh
