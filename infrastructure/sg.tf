resource "huaweicloud_networking_secgroup" "app_http" {
  name        = "application"
  description = "security group for application"
}

resource "huaweicloud_networking_secgroup_rule" "application" {
  security_group_id = huaweicloud_networking_secgroup.app_http.id
  direction         = "ingress"
  action            = "allow"
  ethertype         = "IPv4"
  ports             = "80"
  protocol          = "tcp"
  priority          = 1
  remote_ip_prefix  = "0.0.0.0/0"
}