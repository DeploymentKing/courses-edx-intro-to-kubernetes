#!/usr/bin/env bash

# https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/
minikube start
minikube status
minikube dashboard

minikube ssh
# The following commands are executed on the minikube host
sudo -i
mkdir /tmp/data
echo 'Hello from Kubernetes storage' > /tmp/data/index.html
# ctrl + D to exit back to your workstation

kubectl create -f chapter_10.1_pv.yaml
kubectl create -f chapter_10.1_pv_claim.yaml

kubectl get pv task-pv-volume
kubectl get pvc task-pv-claim

kubectl create -f chapter_10.1.yaml
kubectl create -f chapter_10.1_svc.yaml

kubectl get service

# Tidy up
kubectl delete service web-service
kubectl delete deployments webserver

# Now try and mount a folder on my host macOs > minikube's vol folder > container's /usr/share/nginx/html folder
# minikube mount HOST_MOUNT_DIRECTORY:VM_MOUNT_DIRECTORY(ex:"/host-home:/vm-home")
minikube mount /Users/leemyring/source/DeploymentKing/courses-edx-intro-to-kubernetes/volume_mount:/home/docker/vol



