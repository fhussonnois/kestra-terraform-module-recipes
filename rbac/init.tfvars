# SPDX-License-Identifier: Apache-2.0
# Copyright (c) The original authors
# Licensed under the Apache Software License version 2.0, available at http://www.apache.org/licenses/LICENSE-2.0

# Kestra - Initial Roles
roles = [
  {
    name        = "IAMFullAccess"
    description = "This role grants full access to Kestra IAM."
    permissions = {
      USER    = ["CREATE", "READ", "UPDATE", "DELETE"]
      ROLE    = ["CREATE", "READ", "UPDATE", "DELETE"]
      GROUP   = ["CREATE", "READ", "UPDATE", "DELETE"]
      BINDING = ["CREATE", "READ", "UPDATE", "DELETE"]
    }
  },
  {
    name        = "IAMReadOnlyAccess"
    description = "This role grants read-only access to Kestra IAM."
    permissions = {
      USER    = ["READ"]
      ROLE    = ["READ"]
      GROUP   = ["READ"]
      BINDING = ["READ"]
    }
  },
  {
    name        = "AdminFullAccess"
    description = "This role grants full access to all Kestra resources."
    permissions = {
      USER        = ["CREATE", "READ", "UPDATE", "DELETE"]
      ROLE        = ["CREATE", "READ", "UPDATE", "DELETE"]
      GROUP       = ["CREATE", "READ", "UPDATE", "DELETE"]
      BINDING     = ["CREATE", "READ", "UPDATE", "DELETE"]
      FLOW        = ["CREATE", "READ", "UPDATE", "DELETE"]
      BLUEPRINT   = ["CREATE", "READ", "UPDATE", "DELETE"]
      TEMPLATE    = ["CREATE", "READ", "UPDATE", "DELETE"]
      NAMESPACE   = ["CREATE", "READ", "UPDATE", "DELETE"]
      EXECUTION   = ["CREATE", "READ", "UPDATE", "DELETE"]
      AUDITLOG    = ["CREATE", "READ", "UPDATE", "DELETE"]
      SECRET      = ["CREATE", "READ", "UPDATE", "DELETE"]
      IMPERSONATE = ["CREATE", "READ", "UPDATE", "DELETE"]
      SETTING     = ["CREATE", "READ", "UPDATE", "DELETE"]
      WORKER      = ["CREATE", "READ", "UPDATE", "DELETE"]
    }
  }
]

# Kestra - Initial Groups
groups = [
  {
    name : "IAMAutomation"
    description : "Group for CI/CD"
    roles : ["IAMFullAccess"]
  },
  {
    name : "Admin"
    description : "Group for CI/CD"
    roles : ["AdminFullAccess"]
  }
]

# Kestra - Initial Services Account
service_accounts = [
  {
    name        = "sa-terraform"
    description = "Service account for Terraform"
    groups      = [IAMAutomation]
  }
]
# Kestra - Initial Users
users = [
  {
    name        = "admin@kestra.io"
    description = "Kestra Admin for Terraform"
    groups      = [AdminFullAccess]
  }
]
