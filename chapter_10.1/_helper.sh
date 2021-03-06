#!/usr/bin/env bash

# Using the hostPath Volume Type Demo
minikube start
minikube status
minikube dashboard

minikube ssh
# The following commands are executed on the minikube host
mkdir -p vol
cd vol
echo "Welcome to Kubernetes" > index.html
cat index.html
pwd # Should return /home/docker/vol
# ctrl + D to exit back to your workstation

kubectl create -f deployment.yaml
kubectl create -f service.yaml

kubectl get service
minikube service -n edx web-service

# Tidy up
kubectl delete service web-service
kubectl delete deployments webserver
