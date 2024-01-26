# Terraform Cloud Foundation

Code which manages configuration and life-cycle of all the Terraform Cloud
foundation. It is designed to be used from a dedicated VCS-Driven Terraform
Cloud workspace that would provision and manage the configuration using
Terraform code (IaC). It uses Hashicorp Vault Secrets to manage secrets.

## Permissions

To manage the resources from that code, provide a token from an account with
`owner` permissions. Alternatively, you can use a token from the `owner` team
instead of a user token.

To read secrets from Hashicorp Vault Secrets, provide a client ID and a key
from a service principals with the secret `reader` role.

## Authentication

The Terraform Cloud provider requires a Terraform Cloud/Enterprise API token in
order to manage resources.

- Set the `TFE_TOKEN` environment variable: The provider can read the TFE_TOKEN environment variable and the token stored there
to authenticate. Refer to [Managing Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables) documentation for more details.

The Hashicorp Vault Secrets provider requires a service principal client ID and
a key in order to manage resources.

- Set the `HCP_CLIENT_ID` environment variable: The provider can read the HCP_CLIENT_ID environment variable and the client ID stored there to authenticate. Refer to [Managing Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables) documentation for more details.

- Set the `HCP_CLIENT_SECRET` environment variable: The provider can read the HCP_CLIENT_SECRET environment variable and the client ID stored there to authenticate. Refer to [Managing Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables) documentation for more details.

## Features

- Manages configuration and life-cycle of Terraform Cloud resources:
  - projects
  - workspaces
  - teams
  - variable sets
  - variables
  - notifications
- Read secrets from Hashicorp Vault Secrets

## Prerequisite

In order to deploy the configuration from this code, you must first create
an organization. You must then manually create a dedicated VCS-driven
Terraform Cloud workspace in the UI.

In order to read secrets from Hashicorp Vault Secrets, you must first create
an organization in Hashicorp Cloud. You must manually create a project, an
application, the secrets, a service principale with `read` permission
and create a key in the UI.

To authenticate into Terraform Cloud during configuration deployment, an
API token must be created. This token must come from an account with `owner`
permission or the `owner` team. An environment variable `TFE_TOKEN` must be
created in the previously created workspace with the value of the generated token.

To authenticate into Hashicorp Vault Secrets during deployment, a service
principal with a key must be created. `HCP_CLIENT_ID` and `HCP_CLIENT_SECRET`
environment variables must be create in the previously created workspace with
the value of the generated key.
