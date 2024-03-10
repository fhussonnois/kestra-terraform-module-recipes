# Terraform Module Recipes For Kestra 🚀

This repository provides some handy Terraform modules to get you using the [Kestra](https://kestra.io/) [Terraform Provider](https://registry.terraform.io/providers/kestra-io/kestra/latest/docs) in no time!

## Module Structure

All provided modules use a standard layout:

```
.
├── main.tf
├── outputs.tf
├── providers.tf
└── variables.tf

```
 
## Projects

### RBAC

Example to initialize default Users, Roles, Group, and Service Account for a new Kestra installation.

```
cd ./rbac
terraform init
terraform apply -var="kestra_api_token=$KESTRA_API_TOKEN" -var-file=./init.tfvars
```

NOTE: This project requires Kestra EE.

### API Tokens

Example to create API Token for a Kestra User or Service Account.

```
cd ./api_tokens
terraform init
terraform apply
```


NOTE: This project requires Kestra EE.

## Licence
This code base is available under the Apache License, version 2.
