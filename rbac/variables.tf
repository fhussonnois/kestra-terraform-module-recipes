# SPDX-License-Identifier: Apache-2.0
# Copyright (c) The original authors
# Licensed under the Apache Software License version 2.0, available at http://www.apache.org/licenses/LICENSE-2.0

# Variables for providers.tf
variable "kestra_api_token" {
  description = "Kestra - API Token"
  type        = string
  sensitive   = true
}

variable "kestra_url" {
  description = "Kestra - Webserver URL"
  type        = string
  sensitive   = false
  default     = "http://localhost:8080"
}

# Variables for main.tf
variable "roles" {
  description = "Kestra - List of 'Roles' to be managed."
  type = list(object({
    name        = string
    description = optional(string)
    permissions = map(list(string))
  }))
  sensitive = false
  default   = []
}

variable "groups" {
  description = "Kestra - List of 'Groups' to be managed."
  type = list(object({
    name        = string
    description = optional(string)
    roles       = optional(set(string))
  }))
  sensitive = false
  default = []
}

variable "service_accounts" {
  description = "Kestra - List of 'Service Accounts' to be managed."
  type = list(object({
    name        = string
    description = optional(string)
    groups      = optional(set(string))
  }))
  sensitive = false
  default   = []
}

variable "users" {
  description = "Kestra - List of 'Users' to be managed."
  type = list(object({
    name        = string
    email       = optional(string)
    firstname   = optional(string)
    lastname    = optional(string)
    description = optional(string)
    groups      = optional(set(string))
  }))
  sensitive = false
  default   = []
}