# Create a new VM instance for Airflow
resource "google_compute_instance" "airflow_server" {
  name         = "airflow-server"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.boot_image
      size  = var.disk_size
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.airflow_server_static_ip.address
    }
  }

  tags = ["http-server", "airflow-server"]

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

  allow_stopping_for_update = true
}

resource "google_compute_address" "airflow_server_static_ip" {
  name = "airflow-server-static-ip"
}

# Create a new VM instance for Superset
resource "google_compute_instance" "superset_server" {
  name         = "superset-server"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.boot_image
      size  = var.disk_size
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.superset_server_static_ip.address
    }
  }

  tags = ["http-server", "superset-server"]

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

  allow_stopping_for_update = true
}

resource "google_compute_address" "superset_server_static_ip" {
  name = "superset-server-static-ip"
}