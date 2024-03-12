# The following locals use logic to determine the workspace associate with each notification configuration.

locals {

  tfc_notifications = flatten([for project_key, project in local.projects :
    flatten([for factory_key, factory in project.factories :
      flatten([for notification in factory.tfc_notifications :
        merge(
          notification,
          {
            workspace = factory_key
          }
        )
      ]) if try(factory.tfc_notifications, null) != null
    ]) if try(project.factories, null) != null
  ])

}