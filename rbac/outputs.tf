# SPDX-License-Identifier: Apache-2.0
# Copyright (c) The original authors
# Licensed under the Apache Software License version 2.0, available at http://www.apache.org/licenses/LICENSE-2.0

# Outputs

output "users_created" {
  description = "List of created Users"
  value       = {
    for name, data in local.username_password_map : name => {
      id       = resource.kestra_user.users[name].id
      username = resource.kestra_user.users[name].username
      password = data.password
      groups = resource.kestra_user.users[name].groups
    }
  }
}

output "service_account_created" {
  description = "List of created Service Accounts"
  value       = {
    for name, data in local.service_account_map : name => {
      id       = resource.kestra_service_account.accounts[name].id
      username = resource.kestra_service_account.accounts[name].username
      group = resource.kestra_service_account.accounts[name].group
    }
  }
}