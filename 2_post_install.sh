#!/bin/bash

echo "Due to a bug, change the image of the DaemonSet to 3.6.5, instead of the 3.7.0 release"

# Execute in All NODES
echo "Perform sudo sysctl net.bridge.bridge-nf-call-iptables=1 in all of your other nodes"
sysctl net.bridge.bridge-nf-call-iptables=1

echo "If kubelet fails after a reboot, check the Swap"

echo "Label all the nodes non-master as worker"
for i in $(kubectl get nodes | grep -v master | grep -v NAME | awk '{ print$1 }');do
  kubectl label node $i node-role.kubernetes.io/worker=worker
done

echo "Install Helm v3"
wget https://get.helm.sh/helm-v3.4.1-linux-arm.tar.gz
tar xvzf helm-v3.4.1-linux-arm64.tar.gz
mv linux-arm/helm /usr/bin/

echo "Install Kubernetes Dashboard"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.4/aio/deploy/recommended.yaml


