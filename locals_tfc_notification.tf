# The following locals use logic to determine the workspace associate with each notification configuration.

locals {

  tfc_notifications = flatten([for project_key, project in local.projects :
    flatten([for component_key, component in project.components :
      flatten([for notification in component.tfc_notifications :
        merge(
          notification,
          {
            workspace = component_key
          }
        )
      ]) if try(component.tfc_notifications, null) != null
    ]) if try(project.components, null) != null
  ])

}