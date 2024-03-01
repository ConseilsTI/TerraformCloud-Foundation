# The following resource block is used to create Terraform Cloud team resources.

module "tfe_teams" {
  source = "./modules/tfe_team"

  for_each = nonsensitive({ for team in local.tfc_teams : team.name => team })

  name                        = each.value.name
  custom_project_access       = try(each.value.custom_project_access, null)
  custom_workspace_access     = try(each.value.custom_workspace_access, null)
  organization                = data.tfe_organization.this.name
  organization_access         = try(each.value.organization_access, null)
  organization_membership_ids = [for value in try(each.value.members, []) : data.tfe_organization_membership.this[value].id]
  project_access              = try(each.value.project_access, null)
  project_id                  = try(tfe_project.project[each.value.project].id, null)
  project_name                = try(each.value.project, null)
  sso_team_id                 = try(each.value.sso_team_id, null)
  token                       = try(each.value.token, false)
  token_expired_at            = try(each.value.token_expired_at, null)
  token_force_regenerate      = try(each.value.token_force_regenerate, null)
  visibility                  = try(each.value.visibility, "organization")
  workspace_access            = try(each.value.workspace_access, null)
  workspace_id                = try(module.tfe_workspaces[each.value.workspace].id, null)
  workspace_name              = try(each.value.workspace, null)
  workspace_permission        = try(each.value.workspace_permission, null)
}