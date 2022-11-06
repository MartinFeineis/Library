variable "gcp_enabled_services" {
  description = "The list of apis necessary for the project"
  type        = list(string)
}

variable "my_project" {
  description = "GCP Project ID to use"
  type = string
}
