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

/* Secrets - populate terraform.tfvars to use locally */

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

/* ToadLester */

variable "tl_int_limit" {
  type = string
  description = "Integer range limit"
  default = "10000"
}

variable "tl_int_mod" {
  type = string
  description = "Integer limit modifier"
  default = "2"
}

variable "tl_int_size" {
  type = string
  description = "Integer loop size"
  default = "100"
}

variable "tl_float_limit" {
  type = string
  description = "Float range limit"
  default = "100"
}

variable "tl_float_mod" {
  type = string
  description = "Float limit modifier"
  default = "1.123"
}

variable "tl_float_size" {
  type = string
  description = "Float loop size"
  default = "10"
}

variable "tl_float_tail" {
  type = string
  description = "Float decimal tail"
  default = "5"
}

variable "tl_exp_limit" {
  type = string
  description = "Exponent range limit"
  default = "250"
}

variable "tl_exp_mod" {
  type = string
  description = "Exponent limit modifier"
  default = "250.43"
}

variable "tl_exp_size" {
  type = string
  description = "Exponent loop size"
  default = "50"
}

variable "tl_exp_tail" {
  type = string
  description = "Exponent decimal tail"
  default = "3"
}
