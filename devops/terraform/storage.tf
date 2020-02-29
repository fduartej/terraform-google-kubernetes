resource "google_storage_bucket" "storage_dev" {
  project       = "${var.project_id}"
  name          = "${var.storage_dev["name"]}"
  location      = "${var.storage_dev["location"]}"
  storage_class = "${var.storage_dev["storageclass"]}"
}

resource "google_storage_bucket" "storage_prd" {
  project       = "${var.project_id}"
  name          = "${var.storage_prd["name"]}"
  location      = "${var.storage_prd["location"]}"
  storage_class = "${var.storage_prd["storageclass"]}"
}