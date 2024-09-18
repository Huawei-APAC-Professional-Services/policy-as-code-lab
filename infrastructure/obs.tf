resource "random_uuid" "obs" {}

resource "huaweicloud_obs_bucket" "lab" {
  #  region = "ap-southeast-1"
  bucket = "lab-${random_uuid.obs.result}"
  acl    = "private"
}