variable "network_name"{
  description = "The name of VPC"
  type = string
}

variable "vm_name" {
  type = string
}

variable "machine_type" {
  type = string
  description = "Machine type of the VM instance."
  default = "e2-small"
}

variable "boot_disk" {
  type = object({
    auto_delete       = bool
    initialize_params = object({
      image = string
    })
  })

  description = "Boot disk configuration."

  default = {
    auto_delete = false
    initialize_params = {
      image = "debian-cloud/debian-11"
    }
  }
}

variable "subnetwork_name" {
  type = string
  
}

variable "ssh_user" {
  type = string
}

variable "ssh_pub_key_path" {
  type = string
}
