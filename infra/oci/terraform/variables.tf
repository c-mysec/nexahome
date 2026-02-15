variable "compartment_ocid" {}
variable "ssh_public_key" {}

variable "region" {
  default = "us-ashburn-1"
}

variable "vm_name" {
  default = "nexahome-a1"
}

variable "availability_domain" {
  description = "Usually AD-1"
  default     = null
}

variable "tenancy_ocid" {
  type = string
}

variable "user_ocid" {
  type = string
}

variable "fingerprint" {
  type = string
}

variable "private_key_path" {
  type = string
}
