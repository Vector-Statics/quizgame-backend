terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.52.0"
    }
  }
}

provider "google" {

  # credentials = file("quiz-game-service-account.json")
  credentials = var.credentials

  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-c"
}

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
    database_version = "POSTGRES_11"
    region = "us-central1"
    settings {
        tier = "db-f1-micro"
    }

    deletion_protection = "false"
}

resource "google_sql_database" "database" {
    name = "quizgamedb"
    instance = google_sql_database_instance.instance.name
}

