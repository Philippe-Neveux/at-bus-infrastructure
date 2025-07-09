variable "location" {
  description = "The location for the BigQuery datasets."
  type        = string
}

variable "dataset_names" {
  description = "A list of BigQuery dataset names to create."
  type        = list(string)
  default     = ["at_bus_bronze", "at_bus_silver", "at_bus_gold"]
}
