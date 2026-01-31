provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name                    = "hackathon-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "hackathon-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_container_cluster" "gke_cluster" {
  name     = "hackathon-gke-cluster"
  location = var.zone

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc_network.name
  subnetwork = google_compute_subnetwork.subnet.name
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  cluster    = google_container_cluster.gke_cluster.name
  location   = var.zone
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 20
  }
}
