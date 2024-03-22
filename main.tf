terraform {
  required_version = ">= 0.11.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.33.0"
    }
  }

  backend "gcs" {
    bucket = "240-infra"
  }
}

provider "google" {
  credentials = "${file("/home/kodingwarrior/240/240-infra/240-credentials.json")}"
  project     = "insight240"
  region      = "us-central1"
}

resource "tls_private_key" "ssh_key_for_240" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_for_240" {
  content         = tls_private_key.ssh_key_for_240.private_key_pem
  filename        = "240_insight.pem"
  file_permission = "0600"
}

resource "local_file" "public_key_for_240" {
  content         = chomp(tls_private_key.ssh_key_for_240.public_key_openssh)
  filename        = "240_insight.pub"
  file_permission = "0600"
}

module "core" {
  source = "./modules/core"
}

module "leaderboard_240" {
  source = "./modules/240-leaderboard"

  public_key_for_240 = local_file.public_key_for_240.content

  subnetwork       = module.core.google_compute_subnetwork["codename_240_subnet_prod"]
  nat_ip           = module.core.google_compute_address["codename_240_subnet_prod"]
}
