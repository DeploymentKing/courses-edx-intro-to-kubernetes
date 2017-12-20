# edX Course - Introduction to Kubernetes
This repo simply contains some of the scripts and config mentioned in the course
[Introduction to Kubernetes](https://courses.edx.org/courses/course-v1:LinuxFoundationX+LFS158x+2T2017/course/).

<!-- toc -->

- [Requirements](#requirements)
  * [Pre-requisites](#pre-requisites)
  * [Install KubeCtl and supporting tools](#install-kubectl-and-supporting-tools)
  * [Install MiniKube and supporting tools](#install-minikube-and-supporting-tools)

<!-- tocstop -->

## Requirements
All these instructions are for macOS only.

### Pre-requisites
Install 
- [Homebrew](https://docs.brew.sh/Installation.html)
- [Homebrew Cask](https://caskroom.github.io/)

### Install kubectl and supporting tools
- `brew install docker-machine docker-machine-driver-xhyve kubectl`

### Install Minikube and supporting tools
- `brew cask install docker virtualbox minikube`
