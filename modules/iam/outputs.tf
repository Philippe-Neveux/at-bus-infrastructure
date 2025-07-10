output "service_account_emails" {
  description = "The email addresses of the created service accounts."
  value = {
    for k, sa in google_service_account.this : k => sa.email
  }
}

output "github_secret_names" {
  description = "The names of the GitHub secrets created."
  value = {
    for k, secret in github_actions_secret.gcp_sa_key : k => secret.secret_name
  }
}