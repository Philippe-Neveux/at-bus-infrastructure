resource "google_storage_bucket" "pne_open_data" {
  name          = var.pne_open_data_bucket_name
  location      = var.location
  force_destroy = true

  uniform_bucket_level_access = true
}
