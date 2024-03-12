output "modules_registry_github_owners_team" {
  description = "The name of the GitHub team who owns the private modules registry."
  value       = module.git_teams["TerraformCloud-ModulesRegistry-Owners"].name
}

output "modules_registry_github_contributors_team" {
  description = "The name of the GitHub team who can contribute to the private modules registry."
  value       = module.git_teams["TerraformCloud-ModulesRegistry-Contributors"].name
}