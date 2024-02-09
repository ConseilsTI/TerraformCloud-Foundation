# The following locals use logic to determine the workspace associate with each notification configuration.

locals {

  tfc_notifications = flatten([for project_key, project in local.projects :
    flatten([for component_key, component in project.components :
      flatten([for notification_key, notification in component.tfc_notifications :
        merge(
          notification,
          {
            name      = lower(notification_key)
            workspace = component_key
          }
        )
      ]) if try(component.tfc_notifications, null) != null
    ]) if try(project.components, null) != null
  ])

}