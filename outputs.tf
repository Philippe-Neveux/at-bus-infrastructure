output "airflow_instance_ip" {
  description = "The external IP address of the Airflow VM instance."
  value       = module.compute.airflow_instance_ip
}

output "github_service_account_email" {
  description = "The email address of the service account for GitHub Actions of the at-bus-infrastructure repository."
  value       = module.iam.github_service_account_email
}
