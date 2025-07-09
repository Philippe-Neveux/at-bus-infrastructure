# 2. Create the service account for GitHub Actions
resource "google_service_account" "gha_at_bus_infrastructure" {
  account_id   = var.github_service_account_id
  display_name = "GitHub Actions Deployer"
  project      = var.project_id
}

# 3. Grant the service account the Editor role on the project
resource "google_project_iam_member" "gha_at_bus_infrastructure_editor" {
  project = var.project_id
  role    = "roles/editor"
  member  = google_service_account.gha_at_bus_infrastructure.member
}

# 4. Create a key for the service account
resource "google_service_account_key" "gha_at_bus_infrastructure_key" {
  service_account_id = google_service_account.gha_at_bus_infrastructure.name
}