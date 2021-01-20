terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  version = "3.52.0"

  # credentials = file("quiz-game-service-account.json")
  credentials = var.credentials

  project = var.project_id #"quiz-game-301913"
  region  = "us-central1"
  zone    = "us-central1-c"
}

# resource "google_compute_network" "vpc_network" {
#   name                    = "terraform-network"
#   auto_create_subnetworks = "true"
# }

# resource "google_compute_instance" "default" {
#   name         = "terraformed-microvm"
#   machine_type = "f1-micro"
#   zone         = "us-central1-a"

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-10"
#       size  = 30
#       type  = "pd-standard"
#     }
#   }

#   network_interface {
#     network = "default"
#     access_config {

#     }
#   }
# }

resource "google_project" "my_project" {
    name       = "Quiz Game"
    project_id = var.project_id
    #org_id     = "1234567"
}

resource "google_app_engine_application" "quizgame" {
    project     = google_project.my_project.project_id
    location_id = "us-central"
}

resource "google_sql_database_instance" "instance"{
    name = "quiz-game-db-instance"
    database_version = "POSTGRESQL_11"
    region = "us-central1"
    settings {
        tier = "db-f1-micro"
    }

    deletion_protection = "true"
}

resource "google_sql_database" "database" {
    name = "quizgamedb"
    instance = google_sql_database_instance.instance.name
}

