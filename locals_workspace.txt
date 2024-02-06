locals {

  # The following locals use logic to determine the project associate with each workspace.
  workspaces = flatten([for projects, project in local.projects :
    flatten([for workspaces, workspace in project.workspaces :
      merge(
        workspace,
        { name = workspaces
        project = projects }
      )
    ])
    if try(project.workspaces, null) != null
  ])

  # The following locals use logic to determine the remote_consomer_ids.
  remote_state_consumer_ids = flatten([for project_key, project in local.projects :
    flatten([for workspace_key, workspace in project.workspaces :
      flatten(workspace.remote_state_consumer_ids)
      if try(workspace.remote_state_consumer_ids, null) != null
    ])
    if try(project.workspaces, null) != null
  ])

}