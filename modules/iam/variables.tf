variable "project_id" {
  description = "The ID of the Google Cloud project."
  type        = string
}

variable "github_service_account_id" {
  description = "The ID for the service account used by GitHub Actions."
  type        = string
  default     = "gha-at-bus-infrastructure"
}