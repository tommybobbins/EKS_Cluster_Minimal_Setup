# EKS_Cluster_Minimal_Setup (WIP) - work in progress.
Worked through EKS example for Creating a VPC, EKS cluster and Adding Ingress or Gateway API

````
$ tofu init
$ tofu plan
$ tofu apply
````

## Goal 

Bootstrap scripts to add an OIDC deployment role, then use github actions to auto-deploy an EKS cluster in AWS.

## Things to think about (notes to self)

- Options to install from the command line instead of github actions.
- Ingress and Gateway API options.