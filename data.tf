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
  for_each    = local.hcp_vault_secrets
  app_name    = each.value.project
  secret_name = each.key
}