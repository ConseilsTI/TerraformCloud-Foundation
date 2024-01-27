# The following resource block is used to create Terraform Cloud team resources.

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

# The following resource block is used to create GitHub team resources.

module "github_teams" {
  source = "./modules/github_team"

  for_each = nonsensitive({ for team in local.github_teams : team.name => team })

  name                      = each.value.name
  description               = try(each.value.description, null)
  privacy                   = try(each.value.privacy, null)
  parent_team_id            = try(each.value.parent_team_id, null)
  ldap_dn                   = try(each.value.ldap_dn, null)
  create_default_maintainer = try(each.value.create_default_maintainer, false)
}