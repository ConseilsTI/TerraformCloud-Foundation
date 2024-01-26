output "team_id" {
  description = "The ID of the team."
  value       = tfe_team.this.id
}

output "team" {
  description = "Terraform Cloud team resource."
  value       = tfe_team.this
}

output "token_id" {
  description = "The ID of the token."
  value       = var.token ? tfe_team_token.this[0].id : null
}

output "token" {
  description = "The generated token."
  value       = var.token ? tfe_team_token.this[0].token : null
  sensitive   = true
}

output "team_project_access_id" {
  description = "The team project access ID."
  value       = var.project_id != null ? tfe_team_project_access.this[0].id : null
}

output "team_project_access" {
  description = "Terraform Cloud team project access resource."
  value       = var.project_id != null ? tfe_team_project_access.this[0] : null
}

output "team_workspace_access_id" {
  description = "The team access ID."
  value       = var.workspace_id != null ? tfe_team_access.this[0].id : null
}

output "team_workspace_access" {
  description = "Terraform Cloud team workspace access resource."
  value       = var.workspace_id != null ? tfe_team_access.this[0] : null
}