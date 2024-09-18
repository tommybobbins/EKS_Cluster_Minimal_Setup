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

internet_attr = {
    "fontsize": "20",
    "bgcolor": "#fff"
}

public_attr = {
    "fontsize": "20",
    "bgcolor": "#bdb"
}

priv_attr = {
    "fontsize": "20",
    "bgcolor": "#bbd"
}

ns1_attr = {
    "fontsize": "20",
    "bgcolor": "#fee"
}

ns2_attr = {
    "fontsize": "20",
    "bgcolor": "#eef"
}

ns3_attr = {
    "fontsize": "20",
    "bgcolor": "#fef"
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
    "bgcolor": "#fdd",
    "orientation": "landscape"
}

db_attr = {
    "fontsize": "20",
    "bgcolor": "#fff"
}

cluster_attr = {
    "fontsize": "35"
    # "orientation": "landscape"
}

with Diagram("EKS Ingress", graph_attr=diag_attr, filename="k8s_resources", show=False, direction="LR"):
  with Cluster("VPC 10.123.0.0/16", graph_attr=vpc_attr):
    with Cluster("Public Subnets", graph_attr=public_attr):
      nlb_pub = ElbNetworkLoadBalancer("NLB")
    with Cluster("Private Subnets", graph_attr=priv_attr):
      with Cluster("EKS Cluster", graph_attr=k8s_attr):
        with Cluster("Namespace: kong-public", graph_attr=ns1_attr): 
          kong_public = Kong("kong-public (simplified)")
        with Cluster("Namespace: echo-service", graph_attr=ns2_attr): 
          with Cluster("Deployment"):
            echo_pod1 = Pod("echo-xyz123")
            echo_pod2 = Pod("echo-abc456")
          echo_svc = SVC("echo")
          echo_ing = Ing("HTTPRoute: echo")
          echo_svc >> Edge(penwidth="2",minlength="0") >> [ echo_pod1, echo_pod2 ] 
          echo_ing >> Edge(penwidth="2") >> echo_svc 
          echo_dep = Deploy("echo")
          echo_dep - [ echo_pod1, echo_pod2 ] 
          # common
        with Cluster("Namespace: ohce-service", graph_attr=ns3_attr): 
          with Cluster("Deployment"):
            ohce_pod1 = Pod("ohce-xyz123")
            ohce_pod2 = Pod("ohce-abc456")
          ohce_svc = SVC("ohce")
          ohce_ing = Ing("HTTPRoute: ohce")
          ohce_svc >> Edge(penwidth="2", minlength="0") >> [ ohce_pod1, ohce_pod2 ] 
          ohce_ing >> Edge(penwidth="2") >> ohce_svc 
          ohce_dep = Deploy("ohce")
          ohce_dep - [ ohce_pod1, ohce_pod2 ] 
          # common
  with Cluster("Internet", graph_attr=internet_attr):
    internet=InternetAlt1("0.0.0.0/0")
    [ echo_ing, ohce_ing ] << Edge(minlen="2",penwidth="2") << kong_public << Edge(minlen="2",penwidth="2") << nlb_pub << Edge(penwidth="2") << internet
