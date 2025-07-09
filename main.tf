terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0"
}

# Enable all necessary project APIs
module "project_services" {
  source     = "./modules/project_services"
}

# Create the service account and its key
module "iam" {
  source                    = "./modules/iam"
  project_id                = var.project_id

  # Ensure APIs are enabled before creating IAM resources
  depends_on = [module.project_services]
}

# Create the VM and its static IP address
module "compute" {
  source                = "./modules/compute"
  zone                  = var.zone
  
  # Ensure APIs are enabled before creating compute resources
  depends_on = [module.project_services]
}

# Create the VM and its static IP address
module "storage" {
  source                = "./modules/storage"
  location              = var.location
  
  # Ensure APIs are enabled before creating compute resources
  depends_on = [module.project_services]
}