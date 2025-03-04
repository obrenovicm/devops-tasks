module "test-vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 10.0.0"

    project_id   = var.project_id
    network_name = "mobrenovic-tf-vpc"

    shared_vpc_host = false


    subnets = [
      {
        subnet_name = "subnet-01"
        subnet_ip = "10.10.10.0/24"
        subnet_region = "europe-west1"
      },
      {
        subnet_name = "subnet-02"
        subnet_ip = "10.10.20.0/24"
        subnet_region = "europe-west1"
      }
    ]
}