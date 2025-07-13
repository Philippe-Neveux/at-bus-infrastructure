variable "zone" {
  description = "The zone to deploy the resources in."
  type        = string
}

variable "machine_type" {
  description = "The machine type for the VM instance."
  type        = string
  default     = "custom-4-8192"
}

variable "boot_image" {
  description = "The boot image for the VM instance."
  type        = string
  default     = "debian-cloud/debian-12"
}

variable "disk_size" {
  description = "The size of the boot disk in GB."
  type        = number
  default     = 30
}