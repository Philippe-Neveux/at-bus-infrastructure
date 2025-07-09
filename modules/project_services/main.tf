# --- API Services ---

# Enable the Cloud Resource Manager API, required to manage other project services
resource "google_project_service" "cloudresourcemanager_api" {
  project            = var.project_id
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

# Enable the Compute Engine API
resource "google_project_service" "compute_api" {
  project            = var.project_id
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}


# 1. Enable the IAM API to allow managing service accounts
resource "google_project_service" "iam_api" {
  project            = var.project_id
  service            = "iam.googleapis.com"
  disable_on_destroy = false
}