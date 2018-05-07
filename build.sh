#!/bin/env bash
repo='codehz/mcpe-server'
#registry='https://registry-1.docker.io/v2'
registry='https://registry.docker-cn.com/v2'

function auth() {
	curl -sL "https://auth.docker.io/token?service=registry.docker.io&scope=repository:$repo:pull" | jq ".token" -r
}
function fetch() {
	curl -sL -L -H "Authorization: Bearer $token" "$1"
}
function download() {
	curl -L -H "Authorization: Bearer $token" "$1"
}

printf "Token: "
token=$(auth)
echo $token
printf "Digest: "
digest=$(fetch "$registry/$repo/manifests/latest" | jq ".fsLayers" | jq ".[0].blobSum" -r)
echo $digest
touch version
if [[ $(< version) != "$digest" ]]; then
	echo Downloading...
	download "$registry/$repo/blobs/$digest">server.tar.gz
	echo $digest>version
fi
echo Extracting...
mkdir -p bin && cd bin
tar xvf ../server.tar.gz