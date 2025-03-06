variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "vpc_name" {
  type = string

}

variable "subnets" {
  type = list(object({
    subnet_name   = string
    ip_cidr_range = string
    region        = string
  }))
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

variable "group-name" {
  type = string
}

variable "base_instance_name" {
  type = string
}

variable "template_name" {
  type = string
}

variable "tags" {
  type = list(string)
}

variable "target_size" {
  type = number
}

variable "named_port" {
  type = object({
    name = string
    port = number
  })
}