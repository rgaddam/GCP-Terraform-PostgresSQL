# GCP Authentication 
# define the GCP authentication file
variable "gcp_auth_file" {
  type        = string
  description = "GCP authentication file"
}
# 

variable "na_network_ref_id" {
  default = "projects/cloud-sql-275018/global/networks/default"
}
# database instance settings
variable "zone" {
  default = "us-central1-f"
}

variable "region" {
  default = "us-central1"
}

variable "instance_name" {
  default = "cloudsql"
}

variable "project" {
  default = "cloud-sql-275018"
}

variable "database_version" {
  default = "POSTGRES_9_6"
}

variable "machine_type" {
  default = "db-f1-micro"
}

variable "disk_type" {
  default = "PD_SSD"
}

variable "disk_size" {
  default = "10"
}

variable "disk_autoresize" {
  default = "true"
}

variable "maintenance_day" {
  default = "7"
}

variable "maintenance_hour" {
  default = "7"
}

variable "maintenance_update_track" {
  default = "stable"
}

variable "backup_enable" {
  default = "true"
}

variable "backup_start_time" {
  default = "06:00"
}

# database settings
variable db_name {
  default = "cloudslq"
}
variable db_charset {
  description = "The charset for the default database"
  default     = ""
}
variable db_collation {
  description = "The collation for the default database. Example for MySQL databases: 'utf8_general_ci'"
  default     = ""
}


# user settings
variable db_user_name {
  default = "cloudsql"
}

variable db_user_host {
  description = "The host for the default user"
  default     = "%"
}

variable db_user_password {
  description = "The password for the default user"
  default     = ""
}