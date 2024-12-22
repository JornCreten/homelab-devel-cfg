# homelab-devel-cfg

## Prerequisites:
- Virtualbox https://www.virtualbox.org/wiki/Downloads
- Vagrant https://developer.hashicorp.com/vagrant/install?product_intent=vagrant

## Running:
This project is designed to create and emulate a k3s cluster with ArgoCD.

ArgoCD will start when the cluster is bootstrapped, and then install all the necessary resources to have a fully functional cluster, ready to start resources and "test stuff".
