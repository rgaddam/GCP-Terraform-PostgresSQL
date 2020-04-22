resource "google_compute_network" "private_network" {
  name = "test-network"
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "test-private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.private_network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "cloudsql" {
  name   = var.instance_name
  project = var.project
  region = var.region
  database_version = var.database_version

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = var.machine_type
    disk_type = var.disk_type
    disk_size = var.disk_size
    disk_autoresize = var.disk_autoresize

    maintenance_window {
      day = var.maintenance_day
      hour = var.maintenance_hour
      update_track = var.maintenance_update_track
    }
    backup_configuration{
      enabled = var.backup_enable
      start_time = var.backup_start_time
    }
    location_preference {
      zone =var.zone
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.private_network.self_link
    }
  }
}

# create database
resource "google_sql_database" "cloudsql" {
  name = var.db_name
  project = var.project
  instance = google_sql_database_instance.cloudsql.name
  charset = var.db_charset
  collation = var.db_collation
}

# create user
resource "random_id" "user_password" {
  byte_length = 8
}
resource "google_sql_user" "cloudslq_user" {
  name = var.db_user_name
  project  = var.project
  instance = "${google_sql_database_instance.cloudsql.name}"
  host = var.db_user_host
  password = "${var.db_user_password == "" ? random_id.user_password.hex : var.db_user_password}"
}