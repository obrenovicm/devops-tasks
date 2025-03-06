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

# variable "network_interface" {
#   type = object({
#     network   = string
#     subnetwork = string
#   })
# }

variable "subnetwork_name" {
  type = string
  
}

variable "metadata_startup_script" {
  type = string
  description = "Startup script for the VM instance."
  default = "./modules/compute/startup.sh"
}