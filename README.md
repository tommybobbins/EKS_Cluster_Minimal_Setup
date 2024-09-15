# EKS_Cluster_Minimal_Setup (WIP) - work in progress.
Worked through EKS example for Creating a VPC, EKS cluster and Adding Ingress or Gateway API


## Bootstrapping

Login to AWS after setting the access key and secret access key. Use the bootstrap directory to create the state bucket,  DynamoDB locking table and Github oidc user to be used to deploy the rest of the terraform.

````
$ export AWS_ACCESS_KEY_ID=""
$ export AWS_SECRET_ACCESS_KEY=""
$ cd bootstrap
$ tofu init
$ tofu plan
$ tofu apply
````

Either create Github Actions for the Project or add terraform.tfvars in both the eks and k8s directories
````
# Set as Variable
AWS_REGION="eu-west-2"
TF_VAR_STATE_BUCKET="bucket_name_created_in_the_bootstrap_process"

# Set as Secret
ROLE_TO_ASSUME=arn:aws:iam::0123456789:role/github-oidc-provider-eksmvp-dev
````
## Infrastructure Deployment

To deploy the infrastructure parts of the stack including the network load balancer, either use the github action ````eks-deployment```` or deploy using the CLI and use ````terraform.tfvars```` with environment variables.

### Example terraform.tfvars

If deploying using the CLI, create ````terraform.tfvars```` in both the eks and k8s directories.  This file may look like the following:

````
state_bucket = "eksmvp-dev20240123456789123450000001"
aws_region = "eu-west-2"
````

## Kubernetes Deployment 

To deploy the kubernetes parts of the stack including the network load balancer, either use the github actions or terraform.tfvars and environment variables to login to AWS.


## Goal 

Bootstrap scripts to add an OIDC deployment role, then use github actions to auto-deploy an EKS cluster in AWS.

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
