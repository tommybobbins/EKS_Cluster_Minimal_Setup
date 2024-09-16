# diagram.py
from diagrams import Cluster, Diagram, Edge
from diagrams.aws.compute import EC2, ECS, EKS, Lambda, EC2Instances
from diagrams.aws.network import ELB, VPC, VPCRouter, NATGateway, InternetGateway, PrivateSubnet, PublicSubnet, ElbNetworkLoadBalancer
from diagrams.aws.network import ELB
from diagrams.aws.storage import S3
from diagrams.aws.general import InternetAlt1
from diagrams.aws.general import OfficeBuilding
from diagrams.k8s.infra import Master, Node
from diagrams.k8s.compute import STS, Deploy, DS, Pod
from diagrams.k8s.group import NS
from diagrams.k8s.network import Ing, SVC
from diagrams.k8s.storage import PVC, Vol
from diagrams.k8s.podconfig import CM, Secret
from diagrams.onprem.network import Kong, Nginx

diag_attr = {
    "fontsize": "20",
}

vpc_attr = {
    "fontsize": "20",
    "bgcolor": "#eed",
    "fgcolor": "#000"
}

public_attr = {
    "fontsize": "20",
    "bgcolor": "#efe"
}

ns_attr = {
    "fontsize": "20",
    "bgcolor": "#fee"
}

aws_attr = {
    "fontsize": "20",
    "bgcolor": "#ded"
}

common_attr = {
    "fontsize": "20",
    "bgcolor": "#ebb"
}

k8s_attr = {
    "fontsize": "20",
    "bgcolor": "#fdd"
}

db_attr = {
    "fontsize": "20",
    "bgcolor": "#fff"
}

cluster_attr = {
    "fontsize": "35"
    # "orientation": "landscape"
}

with Diagram("k8s resources", graph_attr=diag_attr, filename="k8s_resources", show=False, direction="TB"):
  with Cluster("VPC 10.123.0.0/16", graph_attr=vpc_attr):
    with Cluster("Public Subnets", graph_attr=public_attr):
      nlb_pub = ElbNetworkLoadBalancer("NLB")
    with Cluster("EKS Cluster", graph_attr=k8s_attr):
      with Cluster("Namespace: echo-service", graph_attr=ns_attr): 
        echo_pod1 = Pod("echo-xyz123")
        echo_pod2 = Pod("echo-abc456")
        echo_svc = SVC("echo")
        echo_ing = Ing("HTTPRoute: echo")
        echo_svc - [ echo_pod1, echo_pod2 ] 
        echo_ing - echo_svc 
        echo_dep = Deploy("echo")
        echo_dep - [ echo_pod1, echo_pod2 ] 
        # common
      with Cluster("Namespace: kong-public", graph_attr=ns_attr): 
        kong_public = Kong("kong-public (simplified)")
  with Cluster("Internet", graph_attr=public_attr):
    internet=InternetAlt1("0.0.0.0/0")
    echo_ing - kong_public - nlb_pub - internet
