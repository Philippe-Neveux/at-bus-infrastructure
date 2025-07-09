# --- API Services ---

# Enable the Cloud Resource Manager API, required to manage other project services
resource "google_project_service" "cloudresourcemanager_api" {
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

# Enable the Compute Engine API
resource "google_project_service" "compute_api" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

# Enable the IAM API to allow managing service accounts
resource "google_project_service" "iam_api" {
  service            = "iam.googleapis.com"
  disable_on_destroy = false
}

# Enable the BigQuery API
resource "google_project_service" "bigquery_api" {
  service            = "bigquery.googleapis.com"
  disable_on_destroy = false
}