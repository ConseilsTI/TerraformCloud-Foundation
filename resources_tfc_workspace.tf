# The following code block is used to create workspace resources in project.

module "tfe_workspaces" {
  source = "./modules/tfe_workspace"

  for_each = nonsensitive({ for workspace in local.tfc_workspaces : workspace.name => workspace })

  name                          = each.value.name
  agent_pool_id                 = try(module.tfe_agent[each.value.agent_pool].agent_pool_id, null)
  allow_destroy_plan            = try(each.value.allow_destroy_plan, null)
  assessments_enabled           = try(each.value.assessments_enabled, null)
  auto_apply                    = try(each.value.auto_apply, null)
  auto_apply_run_trigger        = try(each.value.auto_apply_run_trigger, null)
  description                   = try(each.value.description, null)
  execution_mode                = try(each.value.execution_mode, null)
  file_triggers_enabled         = try(each.value.file_triggers_enabled, null)
  global_remote_state           = try(each.value.global_remote_state, null)
  organization                  = data.tfe_organization.this.name
  project_id                    = tfe_project.project[each.value.project].id
  queue_all_runs                = try(each.value.queue_all_runs, null)
  remote_state_consumer_ids     = try([for value in each.value.remote_state_consumer_ids : data.tfe_workspace.this[value].id], null)
  run_tasks = flatten([for value in concat(local.tfc_default_run_tasks, try(each.value.run_tasks, [])) : 
    { 
      enforcement_level = try(value.enforcement_level, "advisory")
      stage             = try(value.stage, "post_plan")
      task_id           = data.data.tfe_organization_run_task.this[value.name].id
    }
  ])
  source_name                   = try(each.value.source_name, null)
  source_url                    = try(each.value.source_url, null)
  speculative_enabled           = try(each.value.speculative_enabled, null)
  structured_run_output_enabled = try(each.value.structured_run_output_enabled, null)
  ssh_key_id                    = try(each.value.ssh_key_id, null)
  tag_names                     = concat(["terraform-managed"], try(each.value.tag_names, []))
  terraform_version             = try(each.value.terraform_version, "latest")
  trigger_patterns              = try(each.value.trigger_patterns, null)
  trigger_prefixes              = try(each.value.trigger_prefixes, null)
  vcs_repo = each.value.vcs_repo ? {
    identifier     = module.git_repository[each.value.name].full_name
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  } : null
  working_directory = try(each.value.working_directory, null)
}