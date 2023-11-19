terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.6"
    }
  }
}

variable "project_id" {
  description = "The default project to manage resources in."
}

variable "region" {
  description = "The default region to manage resources in."
}

provider "google" {
  project = var.project_id
  region  = var.region
}