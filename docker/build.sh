#!/bin/bash -e

VERSION=$1
if [[ -z ${VERSION} ]]
then
	echo "Usage: $0 domjudge-version"
	echo "	For example: $0 5.3.0"
	exit 1
fi

URL=https://www.domjudge.org/releases/domjudge-${VERSION}.tar.gz
FILE=domjudge.tar.gz

echo "[..] Downloading DOMjudge version ${VERSION}..."

if ! curl -f -s -o ${FILE} ${URL}
then
	echo "[!!] DOMjudge version ${VERSION} file not found on https://www.domjudge.org/releases"
	exit 1
fi

echo "[ok] DOMjudge version ${VERSION} downloaded as domjudge.tar.gz"; echo

echo "[..] Building Docker image for judgehost using intermediate build image..."
docker build -t domjudge/judgehost:${VERSION}-build -f judgehost/Dockerfile.build .
docker rm -f domjudge-judgehost-${VERSION}-build > /dev/null 2>&1 || true
docker run -it --name domjudge-judgehost-${VERSION}-build --privileged domjudge/judgehost:${VERSION}-build
docker cp domjudge-judgehost-${VERSION}-build:/chroot.tar.gz .
docker cp domjudge-judgehost-${VERSION}-build:/judgehost.tar.gz .
docker rm -f domjudge-judgehost-${VERSION}-build
docker rmi domjudge/judgehost:${VERSION}-build
docker build -t ntubapp/judgehost:${VERSION} -f judgehost/Dockerfile .
echo "[ok] Done building Docker image for judgehost"

echo "All done. Image ntubapp/judgehost:${VERSION} created"
echo "If you are a DOMjudge maintainer with access to the domjudge organization on Docker Hub, you can now run the following command to push them to Docker Hub:"
echo "$ docker push ntubapp/judgehost:${VERSION}"
echo "If this is the latest release, also run the following command:"
echo "$ docker tag ntubapp/judgehost:${VERSION} ntubapp/judgehost:latest && docker push ntubapp/judgehost:latest"
