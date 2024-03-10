# SPDX-License-Identifier: Apache-2.0
# Copyright (c) The original authors
# Licensed under the Apache Software License version 2.0, available at http://www.apache.org/licenses/LICENSE-2.0

terraform {
  required_providers {
    kestra = {
      # source  = "terraform.local/local/kestra"
      version = "0.5.0"
    }
  }
}

// Configure the Kestra provider
provider "kestra" {
  api_token = var.kestra_api_token
  url = var.kestra_url
}
