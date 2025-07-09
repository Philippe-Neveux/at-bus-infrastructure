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