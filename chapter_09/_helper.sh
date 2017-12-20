#!/usr/bin/env bash

# Deploying an Application Using the Minikube GUI I
minikube status
minikube dashboard

# Accessing the Application Using the Exposed NodePort
minikube ip

# Permanently save the namespace for all subsequent kubectl commands in that context.
kubectl create namespace edx
kubectl config set-context $(kubectl config current-context) --namespace=edx

# Deploying the Application Using the CLI II
kubectl create -f deployment.yaml
kubectl get deployments
kubectl get replicasets --all-namespaces=true
kubectl get replicasets
kubectl get pods

# Create a Service and Expose It to the External World with NodePort I
kubectl create -f service.yaml

# Create a Service and Expose It to the External World with NodePort II
kubectl get service
kubectl describe svc web-service
minikube service -n edx web-service

# Exploring Labels and Selectors I
kubectl describe pod webserver-bdbc4585d-7w4jc

# Exploring Labels and Selectors II
kubectl get pods -L app,label2

# Exploring Labels and Selectors III
kubectl get pods -l app=webserver
kubectl get pods -l app=webserver1

# Tidy up
kubectl delete service web-service
kubectl delete deployments webserver
