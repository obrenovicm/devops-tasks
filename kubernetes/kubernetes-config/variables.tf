variable "namespace_name" {
  type = string
  default = "test"
}

variable "deployment_name" {
  type = string
  default = "test"
}

variable "deployment_label" {
  type = string
  default = "test"
}

variable "pod_label" {
  type = string
  default = "test"
}

variable "container_image" {
  type = string
}

variable "container_name" {
  type = string
}

variable "service_name" {
  type = string
  default = "test"
}

variable "service_port" {
  type = number
}

variable "service_target_port" {
  type = number
}

variable "service_type" {
  type = string
  description = "ClusterIP, ExternalName, NodePort, ClusterIP or LoadBalancer"
}