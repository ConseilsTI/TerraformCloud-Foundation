locals {

  # The following locals use logic to determine the variable sets at project level.
  tfc_project_level_variable_sets = flatten([for project_key, project in local.projects :
    flatten([for variable_set in project.tfc_variable_sets :
      merge(
        variable_set,
        {
          projects = [project_key]
        }
      )
    ]) if try(project.tfc_variable_sets, null) != null
  ])

  # The following locals use logic to determine the variable sets at workspace level.
  tfc_workspace_level_variable_sets = flatten([for project_key, project in local.projects :
    flatten([for factory_key, factory in project.factories :
      flatten([for variable_set in factory.tfc_variable_sets :
        merge(
          variable_set,
          {
            workspaces = [factory_key]
          }
        )
      ]) if try(factory.tfc_variable_sets, null) != null
    ]) if try(project.factories, null) != null
  ])

  # This is to concat all variable sets.
  tfc_variable_sets = concat(
    local.tfc_organization_variable_sets,
    local.tfc_project_level_variable_sets,
    local.tfc_workspace_level_variable_sets
  )

  # The following locals use logic to determine the project associated to a variable sets.
  tfc_project_variable_sets = flatten([for variable_set in local.tfc_variable_sets :
    flatten([for project in flatten(variable_set.projects) :
      merge(
        variable_set,
        {
          project = project
        }
      )
    ])
    if try(variable_set.projects, null) != null
  ])

  # The following locals use logic to determine the workspace associated to a variable sets.
  tfc_workspace_variable_sets = flatten([for variable_set in local.tfc_variable_sets :
    flatten([for workspace in flatten(variable_set.workspaces) :
      merge(
        variable_set,
        {
          workspace = workspace
        }
      )
    ])
    if try(variable_set.workspaces, null) != null
  ])

}