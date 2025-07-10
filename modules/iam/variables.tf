variable "project_id" {
  description = "The ID of the Google Cloud project."
  type        = string
}

variable "region" {
  description = "The region of the Google Cloud project."
  type        = string
}

variable "zone" {
  description = "The zone to deploy the resources in."
  type        = string
}

variable "service_accounts" {
  description = "A map of service accounts to create. The key is the logical name, and the value is an object with 'account_id' and 'display_name'."
  type = map(object({
    account_id    = string
    display_name  = string
    project_roles = list(string)
    repository    = string
  }))
  default = {
    gha_at_bus_load = {
      account_id    = "at-bus-load"
      display_name  = "GitHub Actions for at-bus-load"
      project_roles = [
        "roles/artifactregistry.writer"
      ]
      repository    = "at-bus-load"
    },
    gha_at_bus_transform = {
      account_id    = "at-bus-transform"
      display_name  = "GitHub Actions for at-bus-transform"
      project_roles = [
        "roles/bigquery.dataEditor",
        "roles/bigquery.jobUser"
      ]
      repository    = "at-bus-transform"
    },
    gha_at_bus_airflow_server = {
      account_id    = "at-bus-airflow-server"
      display_name  = "GitHub Actions for at-bus-airflow-server"
      project_roles = [
        "roles/artifactregistry.admin",
        "roles/bigquery.dataEditor",
        "roles/bigquery.jobUser",
        "roles/bigquery.metadataViewer",
        "roles/compute.instanceAdmin.v1",
        "roles/iam.serviceAccountUser",
        "roles/storage.admin",
        "roles/storage.bucketViewer"
      ]
      repository    = "at-bus-airflow-server"
    },
    gha_at_bus_superset_server = {
      account_id    = "at-bus-superset-server"
      display_name  = "GitHub Actions for at-bus-superset-server"
      project_roles = [
        "roles/bigquery.dataViewer",
        "roles/bigquery.jobUser",
        "roles/bigquery.metadataViewer",
        "roles/compute.instanceAdmin.v1",
        "roles/iam.serviceAccountUser"
      ]
      repository    = "at-bus-superset-server"
    }
  }
}

variable "github_token" {
  description = "A GitHub personal access token with permissions to write repository secrets."
  type        = string
  sensitive   = true
}