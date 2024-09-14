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

````
aws eks --region eu-west-2 update-kubeconfig --name $(aws eks list-clusters --region=eu-west-2 --query 'clusters[]' --output text)
````

## Outputs

````
curl http://k8s-nginxgat-nginxgat-5d8a903d87-d761397e23239b9d.elb.eu-west-2.amazonaws.com -H "Host: cafe.chegwin.org"  -k
Server address: 10.123.156.92:8080
Server name: coffee-56b44d4c55-c6chn
Date: 14/Sep/2024:19:06:00 +0000
URI: /
Request ID: ea91727de9f12e1afcefd3ba4c191480


curl https://k8s-nginxgat-nginxgat-5d8a903d87-d761397e23239b9d.elb.eu-west-2.amazonaws.com -H "Host: cafe.chegwin.org"  -k
Server address: 10.123.156.92:8080
Server name: coffee-56b44d4c55-c6chn
Date: 14/Sep/2024:19:05:23 +0000
URI: /
Request ID: 5812678db94e2f9225e67fab47172509

NAME                                        READY   STATUS    RESTARTS   AGE
pod/nginx-gateway-fabric-57d77c8ccf-ptglg   2/2     Running   0          8m16s

NAME                           TYPE           CLUSTER-IP      EXTERNAL-IP                                                                     PORT(S)                      AGE
service/nginx-gateway-fabric   LoadBalancer   172.20.80.177   k8s-nginxgat-nginxgat-5d8a903d87-d761397e23239b9d.elb.eu-west-2.amazonaws.com   80:31898/TCP,443:31047/TCP   8m16s
NAME                          READY   STATUS    RESTARTS   AGE
pod/coffee-56b44d4c55-c6chn   1/1     Running   0          21m

NAME                                     CLASS   ADDRESS                                                                         PROGRAMMED   AGE
gateway.gateway.networking.k8s.io/cafe   nginx   k8s-nginxgat-nginxgat-5d8a903d87-d761397e23239b9d.elb.eu-west-2.amazonaws.com   True         21m

NAME                                         HOSTNAMES              AGE
httproute.gateway.networking.k8s.io/coffee   ["cafe.chegwin.org"]   21m
