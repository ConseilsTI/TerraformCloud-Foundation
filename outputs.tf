output "hcp_vault_secrets_app_name" {
  description = "The name of the Hashicorp Vault Secrets app where team token will be stored."
  value       = local.hcp_vault_secrets_app_name
}

output "manage_modules_team_token" {
  description = "The token of the team with `manage-modules` access."
  value       = module.tfe_teams["manage-modules"].token
  sensitive   = true
}

output "modules_registry_github_contributors_team" {
  description = "The id of the GitHub team who can contribute to the private modules registry."
  value       = module.git_teams["TerraformCloud-ModulesRegistry-Contributors"].id
}

output "modules_registry_github_owners_team" {
  description = "The id of the GitHub team who owns the private modules registry."
  value       = module.git_teams["TerraformCloud-ModulesRegistry-Owners"].id
}
