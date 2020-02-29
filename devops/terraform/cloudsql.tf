## PRD ##
resource "google_compute_global_address" "private_ip_address_prd" {
  provider      = "google-beta"
  project       = "${var.project_id}"
  name          = "private-ip-range-prd"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "${google_compute_network.vpc_prd.self_link}"
}

resource "google_service_networking_connection" "private_vpc_connection_prd" {
  provider                = "google-beta"
  network                 = "${google_compute_network.vpc_prd.self_link}"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = ["${google_compute_global_address.private_ip_address_prd.name}"]
}

resource "random_id" "num_aleatorio_prd" {
  byte_length = 2
}

resource "google_sql_database_instance" "cloudsql-prd" {
  provider         = "google-beta"
  project          = "${var.project_id}"
  name             = "${var.cloudsql_prd["name"]}-${random_id.num_aleatorio_prd.hex}"
  database_version = "${var.cloudsql_prd["version"]}"
  region           = "${var.cloudsql_prd["region"]}"

  depends_on = [ 
    "google_service_networking_connection.private_vpc_connection_prd"
  ]

  settings {
    tier              = "${var.cloudsql_prd["tier"]}"
    disk_type         = "${var.cloudsql_prd["disktype"]}"
    disk_size         = "${var.cloudsql_prd["disksize"]}"    
    disk_autoresize   = true

    backup_configuration {
      enabled = true
    }

    ip_configuration {
      ipv4_enabled    = true
      private_network = "${google_compute_network.vpc_prd.self_link}"      
    }
  }
}

resource "google_sql_user" "users-prd" {
  project  = "${var.project_id}"
  name     = "${var.cloudsql_prd_user["name"]}"
  password = "${var.cloudsql_prd_user["password"]}"
  instance = "${google_sql_database_instance.cloudsql-prd.name}"  
}

## DEV ##

resource "google_compute_global_address" "private_ip_address_dev" {
  provider      = "google-beta"
  project       = "${var.project_id}"
  name          = "private-ip-range-dev"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "${google_compute_network.vpc_dev.self_link}"
}

resource "google_service_networking_connection" "private_vpc_connection_dev" {
  provider                = "google-beta"  
  network                 = "${google_compute_network.vpc_dev.self_link}"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = ["${google_compute_global_address.private_ip_address_dev.name}"]
}

resource "random_id" "num_aleatorio" {
  byte_length = 2
}

resource "google_sql_database_instance" "cloudsql_dev" {
  provider         = "google-beta"
  project          = "${var.project_id}"
  name             = "${var.cloudsql_dev["name"]}-${random_id.num_aleatorio.hex}"
  database_version = "${var.cloudsql_dev["version"]}"
  region           = "${var.cloudsql_dev["region"]}"

  depends_on = [
    "google_service_networking_connection.private_vpc_connection_dev"
  ]

  settings {
    tier            = "${var.cloudsql_dev["tier"]}"
    disk_type       = "${var.cloudsql_dev["disktype"]}"
    disk_size       = "${var.cloudsql_dev["disksize"]}"    
    disk_autoresize = true

    backup_configuration {
      enabled = true
    }

    ip_configuration {
      ipv4_enabled    = true
      private_network = "${google_compute_network.vpc_dev.self_link}"
      ## require_ssl     = true ##
    }
  }
}

resource "google_sql_user" "users" {
  project  = "${var.project_id}"
  name     = "${var.cloudsql_dev_user["name"]}"
  password = "${var.cloudsql_dev_user["password"]}"
  instance = "${google_sql_database_instance.cloudsql_dev.name}"  
}