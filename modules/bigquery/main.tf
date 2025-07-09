resource "google_bigquery_dataset" "datasets" {
  for_each    = toset(var.dataset_names)
  dataset_id  = each.key
  location    = var.location
  description = "Dataset for ${each.key} data"
}
