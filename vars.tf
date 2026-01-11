variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "app" {
  type    = string
  default = "toadlester"
}

variable "port" {
  type    = number
  default = 8899
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "repository" {
  type    = string
  default = "ghcr.io/maroda/toadlester"
}

variable "release" {
  type    = string
  default = "latest"
}

variable "tcount" {
  type    = number
  default = 1
}

variable "qnet" {
  type    = string
  default = "monteverdi"
}

variable "qnetport" {
  type    = number
  default = 8090
}

variable "qnetrepository" {
  type    = string
  default = "ghcr.io/maroda/monteverdi"
}

variable "qnetrelease" {
  type    = string
  default = "latest"
}

/* Secrets - populate tf.tfvars to use locally */

variable "dnsapex" {
  description = "Domain apex"
  type        = string
}

variable "dnstoken" {
  description = "API Token for DNSimple access"
  type        = string
}

variable "dnsaccount" {
  description = "Account ID for DNSimple access"
  type        = number
}

variable "dnscertid" {
  description = "Certificate ID for domain apex"
  type        = number
}