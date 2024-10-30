terraform {
  required_providers {
    kubernetes = {
      source  = "opentofu/kubernetes"
      version = "2.32.0"
    }
  }

  backend "kubernetes" {
    secret_suffix = "namespace.valkey"
  }
}

provider "kubernetes" {

}
