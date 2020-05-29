#!/bin/bash
set -e

docker network create domjudge
docker network create --internal domjudge_internal
