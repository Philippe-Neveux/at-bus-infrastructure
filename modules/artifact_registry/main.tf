resource "google_artifact_registry_repository" "repositories" {
  for_each      = toset(var.repository_names)
  location      = var.location
  repository_id = each.key
  description   = "Repository for ${each.key}"
  format        = var.repository_format
}
