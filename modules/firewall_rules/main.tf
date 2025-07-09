# Firewall rule for Airflow server
resource "google_compute_firewall" "allow_airflow" {
  name    = "allow-airflow-ingress"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["airflow-server"]
}

# Firewall rule for Superset server
resource "google_compute_firewall" "allow_superset" {
  name    = "allow-superset-ingress"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8088"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["superset-server"]
}