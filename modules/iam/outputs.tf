output "github_service_account_email" {
  description = "The email address of the service account for GitHub Actions of the at-bus-infrastructure repository."
  value       = google_service_account.gha_at_bus_infrastructure.email
}