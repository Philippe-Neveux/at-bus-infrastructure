variable "zone" {
  description = "The zone to deploy the resources in."
  type        = string
}

variable "airflow_instance_name" {
  description = "The name of the VM instance."
  type        = string
  default     = "airflow-server"
}

variable "machine_type" {
  description = "The machine type for the VM instance."
  type        = string
  default     = "e2-medium"
}

variable "boot_image" {
  description = "The boot image for the VM instance."
  type        = string
  default     = "debian-cloud/debian-12"
}