variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "vpc-01"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "subnet-01"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

#route
resource "google_compute_route" "route" {
  name         = "route-01"
  dest_range   = "0.0.0.0/0"
  network      = google_compute_network.vpc.name
  next_hop_ip = "10.10.1.0"
  priority    = 1000
}

