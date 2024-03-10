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
variable "kestra_user_id" {
  description = "Kestra - The user ID for which API tokens are to be retrieved."
  type        = string
  sensitive   = false
}

variable "kestra_token_name" {
  description = "Kestra - The name of the new API Token."
  type        = string
  sensitive   = false
}

variable "kestra_token_description" {
  description = "Kestra - The description of the new API Token."
  type        = string
  sensitive   = false
  default = "Created from Terraform Kestra Provider"
}

variable "kestra_token_max_age" {
  description = "Kestra - The time the token remains valid since creation (ISO 8601 duration format)."
  type        = string
  sensitive   = false
  default = "PT1H"
}

variable "kestra_token_extended" {
  description = "Kestra - Specify whether the expiry date is automatically moved forward by max age whenever the token is used."
  type        = bool
  sensitive   = false
  default = false
}
