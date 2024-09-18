module "core_network" {
  source   = "../modules/tf-hwc-vpc"
  vpc_name = "core"
  vpc_cidr = "10.0.0.0/16"
  subnets = [
    {
      name = "node-subnet",
      cidr = "10.0.0.0/24"
    },
    {
      name = "pod-subnet",
      cidr = "10.0.1.0/24"
    },
    {
      name = "elb-subnet",
      cidr = "10.0.3.0/24"
    }
  ]
}

resource "huaweicloud_vpc_eip" "kube_eip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "kube-api"
    size        = 100
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

resource "huaweicloud_cce_cluster" "main" {
  name                   = "policy-as-code"
  flavor_id              = "cce.s1.small"
  vpc_id                 = module.core_network.vpc_id
  subnet_id              = module.core_network.subnets["node-subnet"]
  container_network_type = "eni"
  eni_subnet_id          = module.core_network.ipv4_subnets["pod-subnet"]
  eip                    = huaweicloud_vpc_eip.kube_eip.address
  delete_all             = true
}

data "huaweicloud_elb_flavors" "main_share_elb" {
  type            = "L4"
  max_connections = 1000000
  cps             = 20000
  bandwidth       = 100
}

resource "huaweicloud_vpc_eip" "main_share_elb" {
  publicip {
    type = "5_bgp"
  }

  bandwidth {
    share_type  = "PER"
    name        = "main-elb-eip"
    size        = 100
    charge_mode = "traffic"
  }
}

resource "huaweicloud_elb_loadbalancer" "main_share_elb" {
  name              = "main-share-elb"
  cross_vpc_backend = true

  vpc_id         = module.core_network.vpc_id
  ipv4_subnet_id = module.core_network.ipv4_subnets["elb-subnet"]

  l4_flavor_id = data.huaweicloud_elb_flavors.main_share_elb.ids[0]

  availability_zone = ["ap-southeast-3a", "ap-southeast-3b"]

  ipv4_eip_id = huaweicloud_vpc_eip.main_share_elb.id
}

output "main_cluster_api_server" {
  value = [for s in huaweicloud_cce_cluster.main.certificate_clusters : s.server if s.name == "externalClusterTLSVerify"][0]
}

output "main_cluster_ca_certificate" {
  value = base64decode([for s in huaweicloud_cce_cluster.main.certificate_clusters : s.certificate_authority_data if s.name == "externalClusterTLSVerify"][0])
}

output "main_cluster_client_key" {
  value = base64decode(huaweicloud_cce_cluster.main.certificate_users[0]["client_key_data"])
}

output "main_cluster_client_certificate" {
  value = base64decode(huaweicloud_cce_cluster.main.certificate_users[0]["client_certificate_data"])
}

output "main_share_elb_id" {
  value = huaweicloud_elb_loadbalancer.main_share_elb.id
}

output "main_share_elb_public_ip" {
  value = huaweicloud_vpc_eip.main_share_elb.address
}