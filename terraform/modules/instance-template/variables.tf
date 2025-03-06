variable "image_link" {
  type = string
}

variable "network_name" {
  type = string
}

variable "subnetwork_name" {
  type = string
}

variable "template_name" {
  type = string
}

variable "machine_type" {
  type = string
  description = "Machine type for the instance template."
  default = "e2-small"
}

variable "tags" {
  type = list(string)
  description = "Tags for the instance template"
}

variable "group-name" {
  type = string
}

variable "base_instance_name" {
  type = string
}

variable "target_size" {
  type = number
}

variable "named_port" {
  type = object({
    name = string
    port = number
  })
  description = "Named port configuration for the instance group"
}