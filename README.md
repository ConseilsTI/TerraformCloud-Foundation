<!-- BEGIN_TF_DOCS -->
# Terraform Cloud Foundation

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

* Set the `TFE_TOKEN` environment variable: The provider can read the TFE\_TOKEN
environment variable and the token stored there to authenticate. Refer to
[Managing Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables) documentation for more details.

### Hashicorp Vault Secrets Authentication

The Hashicorp Vault Secrets provider requires a service principal client ID and
a key in order to manage resources.

* Set the `HCP_CLIENT_ID` environment variable: The provider can read the HCP\_CLIENT\_ID
environment variable and the client ID stored there to authenticate. Refer to
[Managing Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables) documentation for more details.

* Set the `HCP_CLIENT_SECRET` environment variable: The provider can read the HCP\_CLIENT\_SECRET
environment variable and the client ID stored there to authenticate. Refer to
[Managing Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables) documentation for more details.

### GitHub Authentication

The GitHub provider requires a GitHub App installation in order to manage resources.

* Set the `GITHUB_APP_ID`, `GITHUB_APP_INSTALLATION_ID`, `GITHUB_APP_PEM_FILE`, and `GITHUB_OWNER`
environment variables. The provider can read the GITHUB\_APP\_ID, GITHUB\_APP\_INSTALLATION\_ID,
GITHUB\_APP\_PEM\_FILE, and GITHUB\_OWNER environment variables to authenticate.

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

## Documentation

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (> 1.6.2)

- <a name="requirement_github"></a> [github](#requirement\_github) (5.44.0)

- <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) (0.76.0)

- <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) (0.48.0)

## Modules

The following Modules are called:

### <a name="module_agent"></a> [agent](#module\_agent)

Source: ./modules/tfe_agent

Version:

### <a name="module_github_teams"></a> [github\_teams](#module\_github\_teams)

Source: ./modules/github_team

Version:

### <a name="module_notifications"></a> [notifications](#module\_notifications)

Source: ./modules/tfe_notification

Version:

### <a name="module_repository"></a> [repository](#module\_repository)

Source: ./modules/github_repository

Version:

### <a name="module_teams"></a> [teams](#module\_teams)

Source: ./modules/tfe_team

Version:

### <a name="module_workspaces"></a> [workspaces](#module\_workspaces)

Source: ./modules/tfe_workspace

Version:

## Required Inputs

No required inputs.

## Optional Inputs

No optional inputs.

## Resources

The following resources are used by this module:

- [tfe_project.project](https://registry.terraform.io/providers/hashicorp/tfe/0.48.0/docs/resources/project) (resource)
- [tfe_project_variable_set.this](https://registry.terraform.io/providers/hashicorp/tfe/0.48.0/docs/resources/project_variable_set) (resource)
- [tfe_variable.variable_set](https://registry.terraform.io/providers/hashicorp/tfe/0.48.0/docs/resources/variable) (resource)
- [tfe_variable.variable_set_tfe_token](https://registry.terraform.io/providers/hashicorp/tfe/0.48.0/docs/resources/variable) (resource)
- [tfe_variable.workspace](https://registry.terraform.io/providers/hashicorp/tfe/0.48.0/docs/resources/variable) (resource)
- [tfe_variable.workspace_tfe_token](https://registry.terraform.io/providers/hashicorp/tfe/0.48.0/docs/resources/variable) (resource)
- [tfe_variable_set.this](https://registry.terraform.io/providers/hashicorp/tfe/0.48.0/docs/resources/variable_set) (resource)
- [tfe_workspace_variable_set.this](https://registry.terraform.io/providers/hashicorp/tfe/0.48.0/docs/resources/workspace_variable_set) (resource)
- [hcp_vault_secrets_secret.this](https://registry.terraform.io/providers/hashicorp/hcp/0.76.0/docs/data-sources/vault_secrets_secret) (data source)
- [tfe_oauth_client.client](https://registry.terraform.io/providers/hashicorp/tfe/0.48.0/docs/data-sources/oauth_client) (data source)
- [tfe_organization.this](https://registry.terraform.io/providers/hashicorp/tfe/0.48.0/docs/data-sources/organization) (data source)
- [tfe_workspace.this](https://registry.terraform.io/providers/hashicorp/tfe/0.48.0/docs/data-sources/workspace) (data source)

## Outputs

No outputs.

<!-- markdownlint-enable -->

<!-- END_TF_DOCS -->