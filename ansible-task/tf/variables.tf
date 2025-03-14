variable "project_id" {
  type = string
}

variable "network_name" {
  type = string

}

variable "subnets" {
  type = list(object({
    subnet_name   = string
    ip_cidr_range = string
    region        = string
  }))
}

variable "ssh_pub_key_path" {
  type = string
}

variable "firewall_rules" {
    type = list(object({
    name          = string
    direction     = string
    source_ranges = list(string)
    target_tags   = optional(list(string))
    priority      = optional(number)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
  }))
}

variable "vm_name" {
  type = string
}

variable "ssh_user" {
  type = string
  
}

variable "ansible_host_name" {
  type = string
}

variable "ssh_private_key_path" {
  type = string
}

# variable "playbook" {
#   type = string
# }
