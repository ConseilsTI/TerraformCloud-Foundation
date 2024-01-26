# The following block are used to retrieve secrets and their latest version values for a given application.
data "hcp_vault_secrets_secret" "this" {
  for_each = local.secrets

  app_name    = each.value.project
  secret_name = each.key
}