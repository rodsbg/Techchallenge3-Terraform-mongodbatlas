# Create a Project
resource "mongodbatlas_project" "atlas-project" {
  org_id = var.atlas_org_id
  name = var.atlas_project_name
}


# Create a Database User
resource "mongodbatlas_database_user" "db-user" {
  username = "user-1"
  password = random_password.db-user-password.result
  project_id = mongodbatlas_project.atlas-project.id
  auth_database_name = "admin"
  roles {
    role_name     = "readWrite"
    database_name = "${var.atlas_project_name}-db"
  }
}

# Create a Database Password
resource "random_password" "db-user-password" {
  length = 16
  special = true
  override_special = "_%@"
}

# Create Database IP Access List 
resource "mongodbatlas_project_ip_access_list" "ip" {
  project_id = mongodbatlas_project.atlas-project.id
  ip_address = var.ip_address
}


resource "mongodbatlas_cluster" "fiap-cluster" {
  project_id   = mongodbatlas_project.atlas-project.id
  name         = "${var.atlas_project_name}-${var.environment}-cluster"
  cluster_type = "REPLICASET"
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = var.atlas_region
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }
  cloud_backup = false
  auto_scaling_disk_gb_enabled = false
  mongo_db_major_version       = var.mongodb_version

  # Provider Settings "block"
  provider_instance_size_name = "M0"
  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name     = var.atlas_region
  
}



# Outputs to Display
output "atlas_cluster_connection_string" { value = mongodbatlas_cluster.fiap-cluster.connection_strings.0.standard_srv }
output "ip_access_list"    { value = mongodbatlas_project_ip_access_list.ip.ip_address }
output "project_name"      { value = mongodbatlas_project.atlas-project.name }
output "username"          { value = mongodbatlas_database_user.db-user.username } 
output "user_password"     { 
  sensitive = true
  value = mongodbatlas_database_user.db-user.password 
  }