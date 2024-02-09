###################################################################################################
# GitHub repositories
###################################################################################################





###################################################################################################
# GitHub teams
###################################################################################################


# The following resource block is used to create GitHub team resources.

module "github_teams" {
  source = "./modules/github_team"

  for_each = nonsensitive({ for team in local.git_teams : team.name => team })

  name                      = each.value.name
  description               = try(each.value.description, null)
  privacy                   = try(each.value.privacy, "closed")
  parent_team_id            = try(each.value.parent_team_id, null)
  ldap_dn                   = try(each.value.ldap_dn, null)
  create_default_maintainer = try(each.value.create_default_maintainer, false)
  repository                = try(each.value.repository, null)
  permission                = try(each.value.permission, null)
}

###################################################################################################
# Terraform Cloud workspaces
###################################################################################################

# The following locals use logic to determine the project associate with each workspace.
locals {
  workspaces = flatten([for project_key, project in local.projects :
    flatten([for workspace_key, workspace in project.workspaces :
      merge(
        workspace.tfc_workspace,
        { name        = workspace_key
          description = workspace.description
        project = project_key }
      ) if try(workspace.tfc_workspace, null) != null
    ]) if try(project.workspaces, null) != null
  ])
}

# The following code block is used to create workspace resources in project.

module "workspaces" {
  source = "./modules/tfe_workspace"

  for_each = nonsensitive({ for workspace in local.workspaces : workspace.name => workspace })

  name                  = each.value.name
  organization          = data.tfe_organization.this.name
  project_id            = tfe_project.project[each.value.project].id
  description           = try(each.value.description, null)
  agent_pool_id         = try(each.value.agent_pool_id, null)
  allow_destroy_plan    = try(each.value.allow_destroy_plan, null)
  auto_apply            = try(each.value.auto_apply, null)
  execution_mode        = try(each.value.execution_mode, null)
  assessments_enabled   = try(each.value.assessments_enabled, null)
  file_triggers_enabled = try(each.value.file_triggers_enabled, null)
  global_remote_state   = try(each.value.global_remote_state, null)
  #remote_state_consumer_ids     = try([for value in each.value.remote_state_consumer_ids : data.tfe_workspace.this[value].id], null)
  queue_all_runs                = try(each.value.queue_all_runs, null)
  source_name                   = try(each.value.source_name, null)
  source_url                    = try(each.value.source_url, null)
  speculative_enabled           = try(each.value.speculative_enabled, null)
  structured_run_output_enabled = try(each.value.structured_run_output_enabled, null)
  ssh_key_id                    = try(each.value.ssh_key_id, null)
  tag_names                     = concat(["terraform-managed"], each.value.tag_names)
  terraform_version             = try(each.value.terraform_version, "latest")
  trigger_prefixes              = try(each.value.trigger_prefixes, null)
  trigger_patterns              = try(each.value.trigger_patterns, null)
  vcs_repo = each.value.vcs_repo ? {
    identifier     = module.repository[each.value.name].full_name
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  } : null
  working_directory = try(each.value.working_directory, null)
}