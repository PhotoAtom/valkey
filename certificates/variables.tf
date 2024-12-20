variable "namespace" {
  default     = "valkey"
  description = "Namespace to be used for deploying Valkey Cluster and related resources."
}

variable "cluster_issuer_name" {
  default     = "photoatom-self-signed-issuer"
  description = "Name for the Cluster Issuer"
}

variable "valkey_ca_name" {
  default     = "valkey-ca-certificate"
  description = "Name for the Certificate Authority for Valkey Cluster"
}

variable "valkey_issuer_name" {
  default     = "valkey-ca-issuer"
  description = "Name for the Issuer for Valkey Cluster"
}

variable "valkey_certificate_name" {
  default     = "valkey-certificate"
  description = "Name for the certificate for Valkey Cluster"
}
