# Centralized naming and environment identifiers
locals {
  project_id = "YOUR_GCP_PROJECT_ID" # <-- Replace with your GCP Project ID
  region     = "us-central1"
  zone       = "us-central1-a"
  env        = "dev"
  prefix     = "learning-${local.env}"
}