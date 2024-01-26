resource "tfe_team" "this" {

  name         = var.name
  organization = var.organization
  visibility   = var.visibility
  sso_team_id  = var.sso_team_id

  dynamic "organization_access" {
    for_each = var.organization_access != null ? [true] : []
    content {
      read_projects           = var.organization_access.read_projects
      manage_projects         = var.organization_access.manage_projects
      read_workspaces         = var.organization_access.read_workspaces
      manage_workspaces       = var.organization_access.manage_workspaces
      manage_policies         = var.organization_access.manage_policies
      manage_policy_overrides = var.organization_access.manage_policy_overrides
      manage_run_tasks        = var.organization_access.manage_run_tasks
      manage_vcs_settings     = var.organization_access.manage_vcs_settings
      manage_membership       = var.organization_access.manage_membership
      manage_modules          = var.organization_access.manage_modules
      manage_providers        = var.organization_access.manage_providers
    }
  }
}

resource "tfe_team_token" "this" {
  count = var.token ? 1 : 0

  team_id          = tfe_team.this.id
  force_regenerate = var.token_force_regenerate
  expired_at       = var.token_expired_at

}

data "tfe_organization_membership" "this" {
  for_each     = var.members != null ? toset(var.members) : []
  organization = var.organization
  email        = each.key
}

resource "tfe_team_organization_members" "this" {
  count   = var.members != null ? 1 : 0
  team_id = tfe_team.this.id
  organization_membership_ids = [
    for member in var.members : data.tfe_organization_membership.this[member].id
  ]
}

resource "tfe_team_project_access" "this" {

  count = var.project_name != null ? 1 : 0

  team_id    = tfe_team.this.id
  project_id = var.project_id
  access     = var.project_access

  dynamic "project_access" {
    for_each = var.custom_project_access != null ? [true] : []
    content {
      settings = var.custom_project_access.settings
      teams    = var.custom_project_access.teams
    }
  }

  dynamic "workspace_access" {
    for_each = var.custom_workspace_access != null ? [true] : []
    content {
      runs           = var.custom_workspace_access.runs
      sentinel_mocks = var.custom_workspace_access.sentinel_mocks
      state_versions = var.custom_workspace_access.state_versions
      variables      = var.custom_workspace_access.variables
      create         = var.custom_workspace_access.create
      locking        = var.custom_workspace_access.locking
      delete         = var.custom_workspace_access.delete
      move           = var.custom_workspace_access.move
      run_tasks      = var.custom_workspace_access.run_tasks
    }
  }

}

resource "tfe_team_access" "this" {

  count = var.workspace_name != null ? 1 : 0

  team_id      = tfe_team.this.id
  access       = var.workspace_access
  workspace_id = var.workspace_id

  dynamic "permissions" {
    for_each = var.workspace_permission != null ? [true] : []
    content {
      runs              = var.workspace_permission.runs
      variables         = var.workspace_permission.variables
      state_versions    = var.workspace_permission.state_versions
      sentinel_mocks    = var.workspace_permission.sentinel_mocks
      workspace_locking = var.workspace_permission.workspace_locking
      run_tasks         = var.workspace_permission.run_tasks
    }
  }

  lifecycle {
    precondition {
      condition     = var.workspace_permission != null ? var.workspace_access != null ? false : true : true
      error_message = "`workspace_permission` value must not be provided if access is provided."
    }
  }
}

