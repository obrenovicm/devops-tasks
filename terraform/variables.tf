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

variable "static-name" {
  type = string
}

variable "hc-name" {
  type = string
}

variable "http_health_check" {
  type = object({
    host               = optional(string)
    port               = optional(number)
    port_specification = optional(string)
    request_path       = optional(string)
    proxy_header       = optional(string)

  })
}

variable "backend-service-name" {
  type = string
}

variable "backend-port-name" {
  type = string
}

variable "url-map-name" {
  type = string  
}

variable "proxy-name" {
  type = string
}

variable "forwarding-rule-name" {
  type = string
}

variable "ip-protocol" {
  type = string
}

variable "port-range" {
  type = string
}

variable "ip_white_list" {
  type = list(string)
}