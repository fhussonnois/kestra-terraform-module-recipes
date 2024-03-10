# SPDX-License-Identifier: Apache-2.0
# Copyright (c) The original authors
# Licensed under the Apache Software License version 2.0, available at http://www.apache.org/licenses/LICENSE-2.0

# Terraform backend
terraform {
  required_version = ">= 1.5.7"

  backend "local" {
    path = "./terraform.tfstate"
  }
}

# Variables
locals {
}

# Data
data "kestra_user_api_tokens" "my_tokens" {
  # Owner
  user_id = var.kestra_user_id
}

# Resources
resource "kestra_user_api_token" "new" {
  # Owner
  user_id = var.kestra_user_id

  # API Token
  name =  var.kestra_token_name
  description = var.kestra_token_description
  max_age = var.kestra_token_max_age
  extended = var.kestra_token_extended

  lifecycle {
    prevent_destroy = true
  }
}

# Outputs
output "new_api_token" {
  value = {
    user_id =  resource.kestra_user_api_token.new.user_id
    token_id = resource.kestra_user_api_token.new.id
    token_name = resource.kestra_user_api_token.new.name
    full_token = resource.kestra_user_api_token.new.full_token
  }
  sensitive = true
}

# Output sensitive full api token text to a local file
resource "null_resource" "write_sensitive_data" {
  triggers = {
    # Ensure this resource runs whenever there's a change in the sensitive data
    token_ids = kestra_user_api_token.new.id
  }
  provisioner "local-exec" {
    command = <<-EOT
      # Write the sensitive data to a local file
      echo "API_TOKEN=${kestra_user_api_token.new.full_token}" > kestra_sensitive_api_token_${kestra_user_api_token.new.name}
    EOT
  }
  depends_on = [kestra_user_api_token.new]
}

output "user_api_tokens" {
  value = {
    user_id =  data.kestra_user_api_tokens.my_tokens.user_id
    api_tokens = data.kestra_user_api_tokens.my_tokens.api_tokens
  }
}
