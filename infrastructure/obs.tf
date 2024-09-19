resource "random_uuid" "obs" {}

resource "huaweicloud_obs_bucket" "lab" {
  bucket = "lab-${random_uuid.obs.result}"
  acl    = "public-read"
}