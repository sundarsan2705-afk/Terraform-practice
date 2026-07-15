# Create a custom Service Account for our VMs
resource "google_service_account" "vm_service_account" {
  account_id   = "${local.prefix}-vm-sa"
  display_name = "Custom Service Account for Test VMs"
}