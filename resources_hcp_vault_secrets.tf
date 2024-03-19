# The following code blode is used to create secret in Hashicorp Vault.

resource "hcp_vault_secrets_secret" "this" {
  for_each     = nonsensitive({ for team in local.tfc_teams : team.name => team if team == true })
  app_name     = "TerraformCloud"
  secret_name  = "TFC_API_TOKEN_${each.value.name}"
  secret_value = module.tfe_teams[each.value.name].token
}