output "google_compute_subnetwork" {
  value = {
    "codename_240_subnet_prod" :  google_compute_subnetwork.codename_240_subnet_prod,
  }
}

output "google_compute_address" {
  value = {
    "codename_240_subnet_prod" : google_compute_address.codename_240_subnet_prod
  }
}
