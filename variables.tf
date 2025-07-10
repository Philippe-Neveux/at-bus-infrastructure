variable "project_id" {
  description = "The ID of the existing Google Cloud project to use."
  type        = string
  default     = "at-bus-465401"
}

variable "location" {
  description = "The location to deploy the resources in."
  type        = string
  default     = "australia-southeast1"
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

variable "github_owner" {
  description = "The GitHub organization or user name that owns the repositories."
  type        = string
  default     = "Philippe-Neveux"
}

variable "github_token" {
  description = "A GitHub personal access token with permissions to write repository secrets."
  type        = string
  sensitive   = true
}