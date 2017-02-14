SHELL=/bin/bash
FOUNDATIONBUILD=$(shell curl -L -H "X-Atlas-Token: ${ATLAS_TOKEN}" https://atlas.hashicorp.com/api/v1/artifacts/geekinc/aws-ubuntu16lts-foundation/amazon.image/search | jq '.versions[0].version' -r)
DOCKERHOSTBUILD=$(shell curl -L -H "X-Atlas-Token: ${ATLAS_TOKEN}" https://atlas.hashicorp.com/api/v1/artifacts/geekinc/aws-ubuntu16lts-dockerhost/amazon.image/search | jq '.versions[0].version' -r)
export FOUNDATIONBUILD
export DOCKERHOSTBUILD
export SHELL

.PHONY: validate-foundation build-foundation validate-dockerhost build-dockerhost

validate-foundation:
	packer validate -var atlas_build_version=$$((FOUNDATIONBUILD+1)) ./templates/foundation/ubuntu16lts/build.json

build-foundation:
	packer build -var atlas_build_version=$$((FOUNDATIONBUILD+1)) ./templates/foundation/ubuntu16lts/build.json

validate-dockerhost:
	packer validate -var atlas_build_version=$$((DOCKERHOSTBUILD+1)) ./templates/base/ubuntu16lts/dockerhost/build.json

build-dockerhost:
	packer build -var atlas_build_version=$$((DOCKERHOSTBUILD+1)) ./templates/base/ubuntu16lts/dockerhost//build.json