provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "github" {
  owner = var.github_owner
  token = var.github_token
}
