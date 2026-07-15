# Centralized naming and environment identifiers
locals {
  project_id = "project-9f7e3645-2203-443a-b00" # <-- Replace with your GCP Project ID
  region     = "us-central1"
  zone       = "us-central1-a"
  env        = "dev"
  prefix     = "learning-${local.env}"
}
