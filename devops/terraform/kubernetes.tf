## DEV ##

resource "google_container_cluster" "cluster-dev" {  
  name             = "${var.gke_dev["name"]}"
  location         = "${var.gke_dev["location"]}"
  project          = "${var.project_id}"
  network          = "${google_compute_network.vpc_dev.self_link}"
  subnetwork       = "${google_compute_subnetwork.subnet_dev.self_link}"  

  ip_allocation_policy {
    
    cluster_ipv4_cidr_block  = "${var.gke_dev["podsrange"]}"
    services_ipv4_cidr_block = "${var.gke_dev["servicerange"]}"
  }

  remove_default_node_pool = true
  initial_node_count       = "${var.node_pool_dev["nodecount"]}"
}

resource "google_container_node_pool" "cluster_dev_nodes" {
  name       = "${var.node_pool_dev["name"]}"
  location   = "${var.node_pool_dev["location"]}"
  cluster    = "${google_container_cluster.cluster-dev.name}"
  project    = "${var.project_id}"

  node_count = "${var.node_pool_dev["nodecount"]}"

  node_config {
    preemptible  = false
    machine_type = "${var.node_pool_dev["machinetype"]}"
    disk_type    = "${var.node_pool_dev["disktype"]}"
    disk_size_gb = "${var.node_pool_dev["disksize"]}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/devstorage.full_control"
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

## PRD ##
resource "google_container_cluster" "cluster-prd" {
  name             = "${var.gke_prd["name"]}"
  location         = "${var.gke_prd["location"]}"
  project          = "${var.project_id}"
  network          = "${google_compute_network.vpc_prd.self_link}"
  subnetwork       = "${google_compute_subnetwork.subnet_prd.self_link}"    

  ip_allocation_policy {
    
    cluster_ipv4_cidr_block  = "${var.gke_prd["podsrange"]}"
    services_ipv4_cidr_block = "${var.gke_prd["servicerange"]}"
  }

  remove_default_node_pool = true
  initial_node_count       = "${var.node_pool_prd["nodecount"]}"
}

resource "google_container_node_pool" "cluster_prd_nodes" {
  name       = "${var.node_pool_prd["name"]}"
  location   = "${var.node_pool_prd["location"]}"
  cluster    = "${google_container_cluster.cluster-prd.name}"
  project    = "${var.project_id}"

  node_count = "${var.node_pool_prd["nodecount"]}"

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  node_config {
    preemptible  = false
    machine_type = "${var.node_pool_prd["machinetype"]}"
    disk_type    = "${var.node_pool_prd["disktype"]}"
    disk_size_gb = "${var.node_pool_prd["disksize"]}"
     
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/devstorage.full_control"
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}




