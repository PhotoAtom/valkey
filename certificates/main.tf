// Certificate Authority to be used with Valkey Cluster
resource "kubernetes_manifest" "valkey_ca" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "Certificate"
    "metadata" = {
      "name"      = "${var.valkey_ca_name}"
      "namespace" = "${var.namespace}"
      "labels" = {
        "app"       = "valkey"
        "component" = "ca"
      }
    }
    "spec" = {
      "isCA" = true
      "subject" = {
        "organizations"       = ["photoatom"]
        "countries"           = ["India"]
        "organizationalUnits" = ["Valkey"]
      }
      "commonName" = "valkey-ca"
      "secretName" = "valkey-ca-tls"
      "duration"   = "70128h"
      "privateKey" = {
        "algorithm" = "ECDSA"
        "size"      = 256
      }
      "issuerRef" = {
        "name"  = "${var.cluster_issuer_name}"
        "kind"  = "ClusterIssuer"
        "group" = "cert-manager.io"
      }
    }
  }
}

// Issuer for the valkey Cluster Namespace
resource "kubernetes_manifest" "valkey_issuer" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "Issuer"
    "metadata" = {
      "name"      = "${var.valkey_issuer_name}"
      "namespace" = "${var.namespace}"
      "labels" = {
        "app"       = "valkey"
        "component" = "issuer"
      }
    }
    "spec" = {
      "ca" = {
        "secretName" = "valkey-ca-tls"
      }
    }
  }

  depends_on = [kubernetes_manifest.valkey_ca]
}

// Certificate for valkey Cluster
resource "kubernetes_manifest" "valkey_certificate" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "Certificate"
    "metadata" = {
      "name"      = "${var.valkey_certificate_name}"
      "namespace" = "${var.namespace}"
      "labels" = {
        "app"       = "valkey"
        "component" = "certificate"
      }
    }
    "spec" = {
      "subject" = {
        "organizations"       = ["photoatom"]
        "countries"           = ["India"]
        "organizationalUnits" = ["Valkey"]
      }
      "commonName" = "valkey"
      "dnsNames" = [
        "*.valkey.valkey.svc.cluster.local",
        "valkey-primary.valkey.svc.cluster.local",
        "*.valkey-primary.valkey.svc.cluster.local",
        "*.valkey-headless.valkey.svc.cluster.local",
        "valkey-headless.valkey.svc.cluster.local",
        "127.0.0.1",
        "localhost",
        "valkey",
      ]
      "secretName" = "valkey-tls"
      "issuerRef" = {
        "name" = "${var.valkey_issuer_name}"
      }
    }
  }

  depends_on = [kubernetes_manifest.valkey_issuer]
}
