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

# Generate password for users
# Usually we must use: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
resource "random_string" "passwords" {
  count            = length(var.users)
  length           = 16
  special          = true
  override_special = "!@#$%^&*_+-="
  upper            = true
  lower            = true
}

# Variables
locals {
  username_password_map = {
    for i, user in var.users : user.name => {
      user : user,
      password : random_string.passwords[i].result
    }
  }
  service_account_map = {
    for user in var.service_accounts : user.name => user
  }
  role_map = {
    for role in var.roles : role.name => role
  }
  group_map = {
    for group in var.groups : group.name => group
  }
  group_bindings_map = {for group in var.groups : "${group.name}-${join("-", group.roles)}" => group}
}

# Kestra's Resources

# Create Roles
resource "kestra_role" "roles" {
  for_each = local.role_map

  name        = each.key
  description = each.value.description

  dynamic "permissions" {
    for_each = each.value.permissions
    content {
      type        = permissions.key
      permissions = permissions.value
    }
  }

  lifecycle {
    #prevent_destroy = true
    #create_before_destroy = true
  }
}

# Create Groups
resource "kestra_group" "groups" {
  for_each    = local.group_map
  name        = each.key
  description = each.value.description
}

# Create Bindings (for group)
resource "kestra_binding" "group_bindings" {
  for_each    = local.group_bindings_map
  external_id = resource.kestra_group.groups[split("-", each.key)[0]].id
  role_id     = resource.kestra_role.roles[split("-", each.key)[1]].id
  type        = "GROUP"

  depends_on = [kestra_role.roles, kestra_group.groups]
}

# Create Users
resource "kestra_user" "users" {
  for_each    = local.username_password_map
  username    = each.key
  email       = each.value.user.email
  first_name  = each.value.user.firstname
  last_name   = each.value.user.lastname
  description = each.value.user.description
  groups      = [for group in each.value.user.groups : kestra_group.groups[group].id]

  lifecycle {
    #prevent_destroy = true
    #create_before_destroy = true
  }

  depends_on = [kestra_role.roles, kestra_group.groups]
}

# Add password to Users
resource "kestra_user_password" "passwords" {
  for_each   = local.username_password_map
  user_id    = resource.kestra_user.users[each.key].id
  password   = each.value.password
  depends_on = [kestra_user.users]
}

# Create Service Accounts
resource "kestra_service_account" "accounts" {
  for_each    = local.service_account_map
  username    = each.key
  description = each.value.description

  dynamic "group" {
    for_each = each.value.groups != {} ? { for group in each.value.groups : group => group } : {}
    content {
      group_id = kestra_group.groups[group.key].id
    }
  }
}

