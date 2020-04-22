# setup the GCP provider
terraform {
  required_version = ">= 0.12"
}
provider "google" {
  project     = "cloud-sql-275018"
  credentials = file("cloud-sql-275018-1c142ea79324.json")
  region      = "us-central1"
  zone        = "us-central1-f"
}

provider "google-beta" {
  project     = "cloud-sql-275018"
  credentials = file("cloud-sql-275018-1c142ea79324.json")
  region      = "us-central1"
  zone        = "us-central1-f"
}