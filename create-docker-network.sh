#!/bin/bash
set -e

docker network create domjudge
docker network create --internal judgejudge_internal
