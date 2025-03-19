variable "network_name" {
  type = string
}

variable "subnetworks" {
  type = list(object({
    subnet_name   = string
    ip_cidr_range = string
    region        = string
  }))
}