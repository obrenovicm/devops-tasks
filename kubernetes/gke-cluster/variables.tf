variable "cluster_name" {
  type = string
}

variable "workers_count" {
  type = number
  default = 3
}

variable "location" {
  type = string
  default = "europe-west1-b"
}

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}