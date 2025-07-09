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
}

resource "google_compute_address" "static_ip" {
  name = "${var.airflow_instance_name}-static-ip"
}