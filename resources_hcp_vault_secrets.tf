# The following code block is used to create the Hashicorp Vault Secret app where team token will be stored.

resource "hcp_vault_secrets_app" "this" {
  app_name = local.hcp_vault_secrets_app_name
}

# The following code blode is used to create secret in Hashicorp Vault.

resource "hcp_vault_secrets_secret" "this" {
  for_each     = nonsensitive({ for team in local.tfc_teams : team.name => team if try(team.token, false) == true })
  app_name     = local.hcp_vault_secrets_app_name
  secret_name  = lower(replace(each.value.name, "/\\W|_|\\s/", "_"))
  secret_value = module.tfe_teams[each.value.name].token
}