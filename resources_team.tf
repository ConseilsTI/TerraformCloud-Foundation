# The following resource block is used to create team resources.

module "teams" {
  source = "./modules/tfe_team"

  for_each = nonsensitive({ for team in local.teams : team.name => team })

  name                    = each.value.name
  organization            = data.tfe_organization.this.name
  visibility              = try(each.value.visibility, "organization")
  sso_team_id             = try(each.value.sso_team_id, null)
  organization_access     = try(each.value.organization_access, null)
  project_name            = try(each.value.project, null)
  project_id              = try(tfe_project.project[each.value.project].id, null)
  project_access          = try(each.value.project_access, null)
  custom_project_access   = try(each.value.custom_project_access, null)
  custom_workspace_access = try(each.value.custom_workspace_access, null)
  workspace_name          = try(each.value.workspace, null)
  workspace_id            = try(module.workspaces[each.value.workspace].id, null)
  workspace_access        = try(each.value.workspace_access, null)
  workspace_permission    = try(each.value.workspace_permission, null)
  token                   = try(each.value.token, false)
  token_force_regenerate  = try(each.value.token_force_regenerate, null)
  token_expired_at        = try(each.value.token_expired_at, null)
  members                 = try(each.value.members, null)
}
