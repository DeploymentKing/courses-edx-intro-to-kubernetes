#!/usr/bin/env bash

# https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/
# Delete Minikube VM
echo "Deleting Minikube..."
minikube delete

# Start up minikube and set docker registry context
echo "Starting Minikube..."
minikube start --memory 4096
minikube status
minikube dashboard

# Permanently save the namespace for all subsequent kubectl commands in that context.
kubectl create namespace edx
kubectl config set-context $(kubectl config current-context) --namespace=edx

# Option 1 - create dir via SSH
# The following commands are executed on the minikube host
minikube ssh
sudo -i
mkdir -p /mnt/aem-author
# ctrl + D to exit back to your workstation

# Option 2 - create via VirtualBox Guest Additions
vboxmanage guestcontrol minikube --username root mkdir --parents /mnt/aem-author

kubectl create -f persistent_volume.yaml
kubectl create -f persistent_volume_claim.yaml

kubectl get pv task-pv-volume
kubectl get pvc task-pv-claim

# Commands to startup the service can be found in _startup.sh
kubectl get service
minikube service -n edx web-service

# Tidy up
kubectl delete service web-service
kubectl delete deployments webserver
kill -9 `cat nohup.pid`
rm nohup.log nohup.pid
