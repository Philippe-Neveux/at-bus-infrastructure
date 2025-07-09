variable "project_id" {
  description = "The ID of the existing Google Cloud project to use."
  type        = string
  default     = "at-bus-465401"
}

variable "location" {
  description = "The location to deploy the resources in."
  type        = string
  default     = "AU"
}

variable "region" {
  description = "The region to deploy the resources in."
  type        = string
  default     = "australia-southeast1"
}

variable "zone" {
  description = "The zone to deploy the resources in."
  type        = string
  default     = "australia-southeast1-b"
}