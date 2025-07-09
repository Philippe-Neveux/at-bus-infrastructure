variable "location" {
  description = "The region of the bucket"
  type        = string
}

variable "pne_open_data_bucket_name" {
  description = "The name of the PNE open data bucket"
  type        = string
  default     = "pne-open-data"
}
