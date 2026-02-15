#!/bin/bash
set -e

docker network inspect edge >/dev/null 2>&1 || docker network create edge
docker network inspect web >/dev/null 2>&1 || docker network create web
docker network inspect internal >/dev/null 2>&1 || docker network create internal
