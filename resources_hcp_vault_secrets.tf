# The following code blode is used to create secret in Hashicorp Vault.

resource "hcp_vault_secrets_secret" "this" {
  for_each     = nonsensitive({ for team in local.tfc_teams : team.name => team if try(team.token, false) == true })
  app_name     = "TerraformCloud"
  secret_name  = lower(replace(each.value.name, "/\\W|_|\\s/", "_"))
  secret_value = module.tfe_teams[each.value.name].token
}