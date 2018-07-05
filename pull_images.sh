#!/bin/bash

set -e

# Check version in https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/
# Search "Running kubeadm without an internet connection"
# For running kubeadm without an internet connection you have to pre-pull the required master images for the version of choice:
KUBE_VERSION=v1.11.0
KUBE_PAUSE_VERSION=3.1
ETCD_VERSION=3.2.18
CORE_DNS_VERSION=1.1.3

GCR_URL=k8s.gcr.io
PRIVATE_URL=registry.cn-shenzhen.aliyuncs.com/cookcodeblog

images=(kube-proxy-amd64:${KUBE_VERSION}
kube-scheduler-amd64:${KUBE_VERSION}
kube-controller-manager-amd64:${KUBE_VERSION}
kube-apiserver-amd64:${KUBE_VERSION}
pause-amd64:${KUBE_PAUSE_VERSION}
etcd-amd64:${ETCD_VERSION}
coredns:${CORE_DNS_VERSION})


for imageName in ${images[@]} ; do
  docker pull $PRIVATE_URL/$imageName
  docker tag  $PRIVATE_URL/$imageName $GCR_URL/$imageName
  docker rmi $PRIVATE_URL/$imageName
done

docker images