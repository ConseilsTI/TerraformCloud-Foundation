# Terraform Cloud Foundation

<!-- [START BADGES] -->
[![Lint Code Base](https://github.com/ConseilsTI/TerraformCloud-Foundation/actions/workflows/linter.yml/badge.svg?event=pull_request)](https://github.com/ConseilsTI/TerraformCloud-Foundation/actions/workflows/linter.yml)
[![Terraform Format](https://github.com/ConseilsTI/TerraformCloud-Foundation/actions/workflows/terraform.yml/badge.svg?event=pull_request)](https://github.com/ConseilsTI/TerraformCloud-Foundation/actions/workflows/terraform.yml)
[![Terraform Docs](https://github.com/ConseilsTI/TerraformCloud-Foundation/actions/workflows/documentation.yml/badge.svg?event=pull_request)](https://github.com/ConseilsTI/TerraformCloud-Foundation/actions/workflows/documentation.yml)
<!-- [END BADGES] -->

Code which manages configuration and life-cycle of all the Terraform Cloud
foundation. It is designed to be used from a dedicated VCS-Driven Terraform
Cloud workspace that would provision and manage the configuration using
Terraform code (IaC). It uses Hashicorp Vault Secrets to manage secrets.

## Permissions

### Terraform Cloud Permissions

To manage the resources from that code, provide a token from an account with
`owner` permissions. Alternatively, you can use a token from the `owner` team
instead of a user token.

### Hashicorp Vault Secrets Permissions

To read secrets from Hashicorp Vault Secrets, provide a client ID and a key
from a service principals with the secret `reader` role.

### GitHub Permissions

To manage the GitHub resources, provide a token from an account or a GitHub App with
appropriate permissions. It should have:

* Read access to `metadata`
* Read and write access to `administration`, `code`, `members`, and `secrets`

## Authentication

### Terraform Cloud Authentication

The Terraform Cloud provider requires a Terraform Cloud/Enterprise API token in
order to manage resources.

* Set the `TFE_TOKEN` environment variable: The provider can read the TFE_TOKEN
environment variable and the token stored there to authenticate. Refer to
[Managing Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables) documentation for more details.

### Hashicorp Vault Secrets Authentication

The Hashicorp Vault Secrets provider requires a service principal client ID and
a key in order to manage resources.

* Set the `HCP_CLIENT_ID` environment variable: The provider can read the HCP_CLIENT_ID
environment variable and the client ID stored there to authenticate. Refer to
[Managing Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables) documentation for more details.

* Set the `HCP_CLIENT_SECRET` environment variable: The provider can read the HCP_CLIENT_SECRET
environment variable and the client ID stored there to authenticate. Refer to
[Managing Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables) documentation for more details.

### GitHub Authentication

The GitHub provider requires a GitHub App installation in order to manage resources.

* Set the `GITHUB_APP_ID`, `GITHUB_APP_INSTALLATION_ID`, `GITHUB_APP_PEM_FILE`, and `GITHUB_OWNER`
environment variables. The provider can read the GITHUB_APP_ID, GITHUB_APP_INSTALLATION_ID,
GITHUB_APP_PEM_FILE, and GITHUB_OWNER environment variables to authenticate.

> Because strings with new lines is not support:</br>
> use "\\\n" within the `pem_file` argument to replace new line</br>
> use "\n" within the `GITHUB_APP_PEM_FILE` environment variables to replace new line</br>

## Features

* Manages configuration and life-cycle of Terraform Cloud resources:
  * projects
  * workspaces
  * teams
  * variable sets
  * variables
  * notifications
  * run tasks
* Manages configuration and life-cycle of GitHub resources:
  * repositories
  * branches protection
  * repositories secrets
  * teams
* Read secrets from Hashicorp Vault Secrets

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

To authenticate into GitHub during deployment, a GitHub App with the required
permission must be created. `GITHUB_APP_ID`, `GITHUB_APP_INSTALLATION_ID`,
`GITHUB_APP_PEM_FILE`, and `GITHUB_OWNER` environment variables must be create
in the previously created workspace with the value of the generated key.
