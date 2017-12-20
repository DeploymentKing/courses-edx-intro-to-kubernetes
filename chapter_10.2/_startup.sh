#!/usr/bin/env bash

# Now try and mount a folder on my host macOs > minikube's vol folder > container's /usr/share/nginx/html folder
# minikube mount HOST_MOUNT_DIRECTORY:VM_MOUNT_DIRECTORY(ex:"/host-home:/vm-home")
echo "Enter location of the folder the contains AEM code base."
echo "e.g. /Users/leemyring/source/DeploymentKing/courses-edx-intro-to-kubernetes/volume_mount"
read aemPath
echo "Attempting to mount $aemPath to /tmp/mount"
nohup minikube mount /Users/leemyring/source/DeploymentKing/courses-edx-intro-to-kubernetes/volume_mount:/tmp/mount > nohup.log 2>&1 &
echo $! > nohup.pid

kubectl create -f deployment.yaml
kubectl create -f service.yaml

kubectl get service
minikube service -n edx web-service
