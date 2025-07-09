variable "location" {
  description = "The location for the Artifact Registry repositories."
  type        = string
}

variable "repository_names" {
  description = "A list of Artifact Registry repository names to create."
  type        = list(string)
  default     = ["airflow-images", "python-projects"]
}

variable "repository_format" {
  description = "The format of the repositories."
  type        = string
  default     = "DOCKER"
}
