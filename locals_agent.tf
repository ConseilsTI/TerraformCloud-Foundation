locals {
  # The following locals use logic to determine the required agent pools.
  agent_pools = flatten([for project_key, project in local.projects :
    flatten([for workspace_key, workspace in project.workspaces :
      # flatten([for tfc_workspace_key, tfc_workspace in workspace.tfc_workspace :
      workspace.tfc_workspace.agent_pool if try(workspace.tfc_workspace.agent_pool, null) != null
      # ]) if try(workspace.tfc_workspace, null) != null
    ]) if try(project.workspaces, null) != null
  ])
}

output "agent_pools" {
  value = local.agent_pools
}