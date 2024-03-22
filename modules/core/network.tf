# google_compute_network
resource "google_compute_network" "codename_240_prod" {
  name                    = "codename-240-prod"
  auto_create_subnetworks = false
}

# google_compute_subnetwork
resource "google_compute_subnetwork" "codename_240_subnet_prod" {
  name          = "codename-240-subnet-prod"
  ip_cidr_range = "10.1.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.codename_240_prod.id
}

# google_compute_firewall
resource "google_compute_firewall" "codename_240_prod_allow_ssh" {
  name        = "codename-240-prod-allow-ssh"
  network     = google_compute_network.codename_240_prod.name
  description = "Allow ssh from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-ssh"]
}

resource "google_compute_firewall" "codename_240_prod_allow_http" {
  name        = "codename-240-prod-allow-http"
  network     = google_compute_network.codename_240_prod.name
  description = "Allow http from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-http"]
}

# google_compute_address
resource "google_compute_address" "codename_240_subnet_prod" {
  name   = "codename-240-subnet-prod"
  region = "us-central1"
}
