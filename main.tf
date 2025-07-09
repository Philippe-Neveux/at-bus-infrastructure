terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0"
}

# Enable the Compute Engine API
resource "google_project_service" "compute_api" {
  project            = var.project_id
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

# Reserve a static external IP address
resource "google_compute_address" "static_ip" {
  name = "${var.airflow_instance_name}-static-ip"

  # Depends on the API being enabled
  depends_on = [google_project_service.compute_api]
}

# Create a new VM instance for Airflow
resource "google_compute_instance" "airflow_server" {
  name         = var.airflow_instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.boot_image
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }

  tags = ["http-server", "airflow-server"]

  # Depends on the API being enabled
  depends_on = [google_project_service.compute_api]
}

# --- GitHub Actions Service Account ---

# 1. Enable the IAM API to allow managing service accounts
resource "google_project_service" "iam_api" {
  project            = var.project_id
  service            = "iam.googleapis.com"
  disable_on_destroy = false
}

# 2. Create the service account for GitHub Actions
resource "google_service_account" "gha_at_bus_infrastructure" {
  account_id   = var.github_service_account_id
  display_name = "GitHub Actions Deployer"
  project      = var.project_id

  # Depends on the IAM API being enabled first
  depends_on = [google_project_service.iam_api]
}

# 3. Grant the service account the Editor role on the project
resource "google_project_iam_member" "gha_at_bus_infrastructure_editor" {
  project = var.project_id
  role    = "roles/editor"
  member  = google_service_account.gha_at_bus_infrastructure.member

  # Depends on the service account being created first
  depends_on = [google_service_account.gha_at_bus_infrastructure]
}

# 4. Create a key for the service account
resource "google_service_account_key" "gha_at_bus_infrastructure_key" {
  service_account_id = google_service_account.gha_at_bus_infrastructure.name
}