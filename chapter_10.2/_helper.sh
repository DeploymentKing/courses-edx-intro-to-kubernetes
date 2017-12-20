#!/usr/bin/env bash

# https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/
minikube start
minikube status
minikube dashboard

minikube ssh
sudo -i
mkdir -p /tmp/mount

kubectl create -f persistent_volume.yaml
kubectl create -f persistent_volume_claim.yaml

kubectl get pv task-pv-volume
kubectl get pvc task-pv-claim

# Now try and mount a folder on my host macOs > minikube's vol folder > container's /usr/share/nginx/html folder
# minikube mount HOST_MOUNT_DIRECTORY:VM_MOUNT_DIRECTORY(ex:"/host-home:/vm-home")
echo "Enter location of the folder the contains AEM code base."
read aemPath
echo "Attempting to mount $aemPath to /tmp/mount"
nohup minikube mount /Users/leemyring/source/DeploymentKing/courses-edx-intro-to-kubernetes/volume_mount:/tmp/mount &

kubectl create -f deployment.yaml
kubectl create -f service.yaml

kubectl get service

minikube service -n edx web-service

# Tidy up
kubectl delete service web-service
kubectl delete deployments webserver
