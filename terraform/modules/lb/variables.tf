variable "instance_group" {
  type = string
  description = "Instance group from group manager."
}

variable "static-name" {
  type = string
}

variable "ip-version" {
  type = string
  default = "IPV4"
  description = "IP version for global address."
}

variable "hc-name" {
  type = string
}

variable "check-interval-sec" {
  type = number
  default = 5
  description = "Check interval for health check"
}

variable "healthy-threshold" {
  type = number
  default = 2
  description = "Healthy threshold for health check"
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

variable "timeout_sec" {
  type = number
  default = 5
}

variable "unhealthy_threshold" {
  type = number
  default = 2
}

variable "backend-service-name" {
  type = string
}

variable "connection-draining-timeout-sec" {
  type = number
  default = 0
}

variable "load-balancing-scheme" {
  type = string
  default = "EXTERNAL"
}

variable "protocol" {
  type = string
  default = "HTTP"
  description = "Protocol used for backend service."
}

variable "backend-port-name" {
  type = string
}

variable "balancing-mode" {
  type = string
  default = "UTILIZATION"
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
  description = "IP protocol in forwarding rule"
}

variable "port-range" {
  type = string
  description = "Port range in forwarding rule"
}

variable "ip_white_list" {
  type = list(string)
  description = "Whitelist IPs for Cloud Armor"
  
}

variable "security-policy-name" {
  type = string
  default = "armor-security-policy"
}