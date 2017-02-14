SHELL=/bin/bash
FOUNDATIONBUILD=$(shell curl -L -H "X-Atlas-Token: ${ATLAS_TOKEN}" https://atlas.hashicorp.com/api/v1/artifacts/geekinc/aws-ubuntu16lts-foundation/amazon.image/search | jq '.versions[0].version' -r)
DOCKERHOSTBUILD=$(shell curl -L -H "X-Atlas-Token: ${ATLAS_TOKEN}" https://atlas.hashicorp.com/api/v1/artifacts/geekinc/aws-ubuntu16lts-dockerhost/amazon.image/search | jq '.versions[0].version' -r)
NGINXBUILD=$(shell curl -L -H "X-Atlas-Token: ${ATLAS_TOKEN}" https://atlas.hashicorp.com/api/v1/artifacts/geekinc/aws-ubuntu16lts-nginx-webserver/amazon.image/search | jq '.versions[0].version' -r)
export FOUNDATIONBUILD
export DOCKERHOSTBUILD
export NGINXBUILD
export SHELL

.PHONY: validate-foundation build-foundation validate-dockerhost build-dockerhost validate-nginx build-nginx validate-nginx-ansible build-nginx-ansible

validate-foundation:
	packer validate -var atlas_build_version=$$((FOUNDATIONBUILD+1)) ./templates/foundation/ubuntu16lts/build.json

build-foundation:
	packer build -var atlas_build_version=$$((FOUNDATIONBUILD+1)) ./templates/foundation/ubuntu16lts/build.json

validate-dockerhost:
	packer validate -var atlas_build_version=$$((DOCKERHOSTBUILD+1)) ./templates/base/ubuntu16lts/dockerhost/build.json

build-dockerhost:
	packer build -var atlas_build_version=$$((DOCKERHOSTBUILD+1)) ./templates/base/ubuntu16lts/dockerhost/build.json

validate-nginx-scripts:
	packer validate -var atlas_build_version=$$((NGINXBUILD+1)) ./templates/base/ubuntu16lts/nginx/scripts_build.json

build-nginx-scripts:
	packer build -var atlas_build_version=$$((NGINXBUILD+1)) ./templates/base/ubuntu16lts/nginx/scripts_build.json

validate-nginx:
	packer validate -var atlas_build_version=$$((NGINXBUILD+1)) ./templates/base/ubuntu16lts/nginx/build.json

build-nginx:
	packer build -var atlas_build_version=$$((NGINXBUILD+1)) ./templates/base/ubuntu16lts/nginx/build.json