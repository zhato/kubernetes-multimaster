#!/bin/bash

MASTERIP=$1
TOKEN=$2
NODEIP=$3
SEQ=$4

swapoff -a

# cd /opt/cni/bin
# tar zxvf /shared/cni-plugins-amd64-v0.6.0.tgz
# tar zxvf /shared/cni-amd64-v0.6.0.tgz

sed "s/127.0.0.1.*node-$SEQ/$NODEIP node-$SEQ/" -i /etc/hosts

echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables

kubeadm join --node-name `hostname` --token $TOKEN $MASTERIP:8080 --discovery-token-ca-cert-hash sha256:5a9acc93ce8ceba392a66e7ba1adbf682c1d0f320597ccff985cb003e970255d
