#!/usr/bin/env bash

green=`tput setaf 2`
reset=`tput sgr0`

# Delete Minikube VM
echo "${green}Deleting Minikube...${reset}"
minikube delete

# Start up minikube and set docker registry context
echo "${green}Starting Minikube...${reset}"
minikube start --memory 4096
minikube status

MINIKUBE_IP=$(minikube ip)
echo "${green}Waiting for Minikube to start up on $MINIKUBE_IP:30000...${reset}"
until $(curl --output /dev/null --silent --head --fail http://$MINIKUBE_IP:30000); do
    printf '.'
    sleep 5
done

echo
echo "${green}Launching dashboard...${reset}"
minikube dashboard

# Create the required mounting directory inside the Minikube VM
echo "${green}Creating mount point on Minikube VM...${reset}"
vboxmanage guestcontrol minikube --username root mkdir --parents /mnt/aem-author

# Permanently save the namespace for all subsequent kubectl commands in that context.
echo "${green}Creating the namespace and persistent volume setup...${reset}"
kubectl create namespace edx
kubectl config set-context $(kubectl config current-context) --namespace=edx
kubectl create -f persistent_volume.yaml
kubectl create -f persistent_volume_claim.yaml

# Now try and mount a folder on my host macOs > minikube's vol folder > container's /usr/share/nginx/html folder
# minikube mount HOST_MOUNT_DIRECTORY:VM_MOUNT_DIRECTORY(ex:"/host-home:/vm-home")
echo "${green}Enter location of the folder the contains AEM code base.${reset}"
echo "e.g. /Users/leemyring/source/DeploymentKing/courses-edx-intro-to-kubernetes/volume_mount"
read aemPath
echo "${green}Attempting to mount $aemPath to /mnt/aem-author${reset}"
nohup minikube mount /Users/leemyring/source/DeploymentKing/courses-edx-intro-to-kubernetes/volume_mount:/mnt/aem-author > nohup.log 2>&1 &
echo $! > nohup.pid

echo "${green}Creating the deployment and service...${reset}"
kubectl create -f deployment.yaml
kubectl create -f service.yaml

echo "${green}Launching service...${reset}"
minikube service -n edx web-service
