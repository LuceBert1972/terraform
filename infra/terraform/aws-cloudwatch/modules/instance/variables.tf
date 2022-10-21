variable "namespace" {
  type = string
}

variable "project_name" {
  type = string
}

variable "ssh_key" {
  type = string
}

variable "subnet" {
  type = object({
    public_a  = any
    public_b  = any
    private_a = any
    private_b = any
  })
}

variable "vpc" {
  type = any
}

variable "region" {
  type = string
}
