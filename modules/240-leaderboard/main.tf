variable "public_key_for_240" {}
variable "subnetwork" {}
variable "nat_ip" {}

resource "google_compute_instance" "leaderboard_main_prod" {
  name         = "leaderboard-main-prod"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  network_interface {
    subnetwork = var.subnetwork.id
    access_config {
      nat_ip = var.nat_ip.address
    }
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  tags = ["allow-http", "allow-ssh"]

  metadata = {
    ssh-keys = "codename-240:${var.public_key_for_240}"
  }
}
