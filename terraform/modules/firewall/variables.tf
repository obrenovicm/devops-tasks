variable "network" {
  type = string
  description = "Name of the network."
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
  description = "A list of firewall rule objects."
}
