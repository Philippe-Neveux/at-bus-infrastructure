terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

# Enable all necessary project APIs
module "project_services" {
  source     = "./modules/project_services"
}

# Create the service accounts and their keys
module "iam" {
  source                  = "./modules/iam"
  project_id              = var.project_id
  github_token            = var.github_token
  region                  = var.region
  zone                    = var.zone

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

# Create the BigQuery datasets
module "bigquery" {
  source     = "./modules/bigquery"
  location   = var.location

  depends_on = [module.project_services]
}

# Create the Artifact Registry repositories
module "artifact_registry" {
  source     = "./modules/artifact_registry"
  location   = var.location

  depends_on = [module.project_services]
}

# Create the firewall rules
module "firewall_rules" {
  source     = "./modules/firewall_rules"

  depends_on = [module.project_services]
}
