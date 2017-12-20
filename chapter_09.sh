#!/usr/bin/env bash

# Deploying an Application Using the Minikube GUI I
minikube status
minikube dashboard

# Deploying an Application Using the Minikube GUI III (
kubectl get deployments
kubectl get replicasets
kubectl get pods

# Exploring Labels and Selectors I
kubectl describe pod webserver-bdbc4585d-7w4jc

# Exploring Labels and Selectors II
kubectl get pods -L app,label2

# Exploring Labels and Selectors III
kubectl get pods -l app=webserver
kubectl get pods -l app=webserver1

# Deploying the Application Using the CLI I
kubectl delete deployments webserver
kubectl get replicasets
kubectl get pods

# Deploying the Application Using the CLI II
kubectl create namespace edx
kubectl create -f chapter_09.yaml
kubectl get replicasets --all-namespaces=true
# Permanently save the namespace for all subsequent kubectl commands in that context.
kubectl config set-context $(kubectl config current-context) --namespace=edx
kubectl get replicasets
kubectl get pods

# Create a Service and Expose It to the External World with NodePort I
kubectl create -f chapter_09_svc.yaml

# Create a Service and Expose It to the External World with NodePort II
kubectl get service
kubectl describe svc web-service

# Accessing the Application Using the Exposed NodePort
minikube ip
