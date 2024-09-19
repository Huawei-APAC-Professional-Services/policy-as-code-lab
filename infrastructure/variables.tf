variable "eip_bandwidth" {
  type = number
  validation {
    condition     = var.eip_bandwidth <= 100
    error_message = "The bandwidth must be no more than 100 Mbit/s"
  }
}