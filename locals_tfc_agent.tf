# The following locals use logic to determine the required agent pools.

locals {

  tfc_agent_pools = flatten([for project_key, project in local.projects :
    flatten([for component_key, component in project.components :
      component.tfc_workspace.agent_pool if try(component.tfc_workspace.agent_pool, null) != null
    ]) if try(project.components, null) != null
  ])

}