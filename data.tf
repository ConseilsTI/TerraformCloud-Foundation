# The following block is use to get information about a Terraform Cloud OAuth client.

data "tfe_oauth_client" "client" {
  organization = data.tfe_organization.this.name
  name         = local.tfc_oauth_client_name
}

# The following block is use to get information about a Terraform Cloud organization.

data "tfe_organization" "this" {
  name = local.tfc_organization_name
}

# The following block is used to retrieve secrets and their latest version values for a given application.

data "hcp_vault_secrets_secret" "this" {
  for_each    = { for secret in local.hcp_vault_secrets : lower("${secret.app_name}-${secret.secret}") => secret }
  app_name    = each.value.app_name
  secret_name = each.value.secret
}

# The following block is use to get information about run tasks in the organization.

data "tfe_organization_run_task" "this" {
  for_each     = nonsensitive(toset(local.tfc_run_tasks))
  name         = each.key
  organization = data.tfe_organization.this.name
}

# The following blick is used to get information about workspace

data "tfe_workspace" "this" {
  for_each = nonsensitive(toset(local.tfc_remote_state_consumer_ids))

  name         = each.key
  organization = data.tfe_organization.this.name
}