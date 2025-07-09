# This file configures the remote backend for Terraform state storage.
# The state file will be stored in a Google Cloud Storage bucket.
terraform {
  backend "gcs" {
    bucket = "at-bus-465401-tfstate"
    prefix = "terraform/state"
  }
}
