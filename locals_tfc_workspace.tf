locals {

  # The following locals use logic to determine the project associate with each workspace.

  tfc_workspaces = flatten([for project_key, project in local.projects :
    flatten([for factory_key, factory in project.factories :
      merge(
        factory.tfc_workspace,
        {
          name        = factory_key
          description = factory.description
          project     = project_key
        }
      ) if try(factory.tfc_workspace, null) != null
    ]) if try(project.factories, null) != null
  ])


  # The following locals use logic to determine the remote_consomer_ids.
  tfc_remote_state_consumer_ids = flatten([for project_key, project in local.projects :
    flatten([for factory_key, factory in project.factories :
      flatten(factory.tfc_workspace.remote_state_consumer_ids) if try(factory.tfc_workspace.remote_state_consumer_ids, null) != null
    ]) if try(project.factories, null) != null
  ])
}