output "airflow_instance_ip" {
  description = "The external IP address of the Airflow VM instance."
  value       = google_compute_instance.airflow_server.network_interface[0].access_config[0].nat_ip
}

output "superset_instance_ip" {
  description = "The external IP address of the Superset VM instance."
  value       = google_compute_instance.superset_server.network_interface[0].access_config[0].nat_ip
}
