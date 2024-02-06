locals {

  # The following locals use logic to determine the required agent pools.
  agent_pools = flatten([for project_key, project in local.projects :
    flatten([for workspace_key, workspace in project.workspaces :
      workspace.tfc_workspace.agent_pool if workspace.tfc_workspace.agent_pool != null
    ])
    if try(project.workspaces, null) != null
  ])

}

output "agent_pools" {
  value = local.agent_pools
}