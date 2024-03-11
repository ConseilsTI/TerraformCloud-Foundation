# The following locals use logic to determine the required agent pools.

locals {

  tfc_agent_pools = flatten([for project_key, project in local.projects :
    flatten([for factory_key, factory in project.factories :
      factory.tfc_workspace.agent_pool if try(factory.tfc_workspace.agent_pool, null) != null
    ]) if try(project.factories, null) != null
  ])

}