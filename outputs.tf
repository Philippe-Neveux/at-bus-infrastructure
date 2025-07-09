output "airflow_instance_ip" {
  description = "The external IP address of the Airflow VM instance."
  value       = google_compute_instance.airflow_server.network_interface[0].access_config[0].nat_ip
}

output "github_service_account_email" {
  description = "The email address of the service account for GitHub Actions of the at-bus-infrastructure repository."
  value       = google_service_account.gha_at_bus_infrastructure.email
}