provider "google" {
  credentials = "${var.service_account_credentials}"
}
provider "google-beta" {
  credentials = "${var.service_account_credentials}"
}

module "project-services" {
  source        = "terraform-google-modules/project-factory/google//modules/project_services"
  version       = "4.0.0"

  project_id                  = "${var.project_id}"
  disable_services_on_destroy = false

  activate_apis = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "sqladmin.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}

resource "google_compute_network" "vpc_dev" {
  project                 = "${var.project_id}"
  name                    = "${var.vpc_dev["name"]}"
  auto_create_subnetworks = "false"
  description             = "${var.vpc_dev["description"]}"  
}

resource "google_compute_subnetwork" "subnet_dev" {
  project       = "${var.project_id}"
  name          = "${var.subnet_dev["name"]}"
  description   = "${var.subnet_dev["description"]}"
  ip_cidr_range = "${var.subnet_dev["iprange"]}"
  region        = "${var.subnet_dev["region"]}"
  network       = "${google_compute_network.vpc_dev.self_link}"

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_network" "vpc_prd" {
  project                 = "${var.project_id}"
  name                    = "${var.vpc_prd["name"]}"
  auto_create_subnetworks = "false"
  description             = "${var.vpc_prd["description"]}"  
}

resource "google_compute_subnetwork" "subnet_prd" {
  project       = "${var.project_id}"
  name          = "${var.subnet_prd["name"]}"
  description   = "${var.subnet_prd["description"]}"
  ip_cidr_range = "${var.subnet_prd["iprange"]}"
  region        = "${var.subnet_prd["region"]}"
  network       = "${google_compute_network.vpc_prd.self_link}"

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}