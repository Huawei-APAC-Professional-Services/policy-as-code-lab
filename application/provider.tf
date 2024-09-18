terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.23.0"
    }
  }
}

data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket = ""
    key    = "infrastructure/terraform.tfstate"
    region = "us-east-1"
    endpoints = {
      s3 = "https://obs.ap-southeast-3.myhuaweicloud.com"
    }
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

terraform {
  backend "s3" {
    bucket = ""
    key    = "app/terraform.tfstate"
    region = "ap-southeast-3"
    endpoints = {
      s3 = "https://obs.ap-southeast-3.myhuaweicloud.com"
    }
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "kubernetes" {
  host = data.terraform_remote_state.infra.outputs.main_cluster_api_server

  client_certificate     = data.terraform_remote_state.infra.outputs.main_cluster_client_certificate
  client_key             = data.terraform_remote_state.infra.outputs.main_cluster_client_key
  cluster_ca_certificate = data.terraform_remote_state.infra.outputs.main_cluster_ca_certificate
}