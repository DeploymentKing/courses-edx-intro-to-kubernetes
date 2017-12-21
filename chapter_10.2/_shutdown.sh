#!/usr/bin/env bash

red=`tput setaf 1`
reset=`tput sgr0`

# Tidy up
echo "${red}Deleting web-service...${reset}"
kubectl delete service web-service
kubectl delete deployments webserver

echo "${red}Shutting down the minikube mount...${reset}"
kill -9 `cat nohup.pid`
rm nohup.log nohup.pid

echo "${red}Deleting Minikube...${reset}"
minikube delete
