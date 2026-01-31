terraform {
  backend "gcs" {
    bucket  = "hcl-devops-terraform-state"
    prefix  = "gke/dev"
  }
}
