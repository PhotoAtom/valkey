terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.16.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }

  backend "kubernetes" {
    secret_suffix = "cluster.valkey"
  }
}

provider "helm" {

}

provider "random" {

}
