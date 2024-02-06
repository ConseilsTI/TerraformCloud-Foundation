locals {

  # The following locals use logic to determine the required agent pool.
  agent_pools = flatten([for project_key, project in local.projects :
    flatten([for agent_pool_key, agent_pool in toset(project.agent_pools) :
      lower(agent_pool_key)
    ])
    if try(project.agent_pools, null) != null
  ])

}