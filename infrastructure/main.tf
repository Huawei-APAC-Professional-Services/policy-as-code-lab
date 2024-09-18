module "core_network" {
  source   = "github.com/Huawei-APAC-Professional-Services/terraform-module/vpc"
  vpc_name = "example"
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

resource "huaweicloud_cce_node_pool" "node_pool" {
  cluster_id               = huaweicloud_cce_cluster.main.id
  name                     = "prodpool"
  os                       = "Ubuntu 22.04"
  initial_node_count       = 2
  flavor_id                = "c7n.xlarge.2"
  password                 = "P@ssw0rd123"
  scall_enable             = true
  min_node_count           = 1
  max_node_count           = 5
  scale_down_cooldown_time = 100
  priority                 = 1
  type                     = "vm"

  root_volume {
    size       = 100
    volumetype = "SSD"
  }
  data_volumes {
    size       = 100
    volumetype = "SSD"
  }
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