locals {

  # The following locals use logic to determine the workspace associate with each notification configuration.
  workspace_notifications = flatten([for project_key, project in local.projects :
    flatten([for workspace_key, workspace in project.workspaces :
      flatten([for notification_key, notification in workspace.notifications :
        merge(
          notification,
          { name      = lower(notification_key)
            workspace = workspace_key
          }
        )
      ])
      if try(workspace.notifications, null) != null
    ])
    if try(project.workspaces, null) != null
  ])

}