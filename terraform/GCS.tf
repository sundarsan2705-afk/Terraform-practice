# 1. Create a Custom VPC Network
resource "google_compute_network" "custom_vpc" {
  name                    = "${local.prefix}-vpc"
  auto_create_subnetworks = false
}

# 2. Create a Subnet
resource "google_compute_subnetwork" "custom_subnet" {
  name          = "${local.prefix}-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = local.region
  network       = google_compute_network.custom_vpc.id
}

# 3. Create Firewall rule for SSH
resource "google_compute_firewall" "allow_ssh" {
  name    = "${local.prefix}-allow-ssh"
  network = google_compute_network.custom_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] # Restrict in production!
  target_tags   = ["ssh-enabled"]
}

# 4. First VM Instance
resource "google_compute_instance" "test_vm_1" {
  name         = "${local.prefix}-vm-1"
  machine_type = "e2-micro"
  zone         = local.zone

  tags = ["ssh-enabled"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.custom_vpc.name
    subnetwork = google_compute_subnetwork.custom_subnet.name
    access_config {} # Public IP
  }

  # Attach the custom IAM service account
  service_account {
    email  = google_service_account.vm_service_account.email
    scopes = ["cloud-platform"]
  }
}

# Output the IP of the first VM
output "vm_1_ip" {
  value = google_compute_instance.test_vm_1.network_interface[0].access_config[0].nat_ip
}