locals {

  # The following locals use logic to determine the variable sets at organization level.
  tfc_organization_level_variable_sets = flatten([for variable_set_key, variable_set in local.tfc_organization_variable_sets :
    merge(
      variable_set,
      {
        name = variable_set_key
      }
    )
  ])

  # The following locals use logic to determine the variable sets at project level.
  tfc_project_level_variable_sets = flatten([for project_key, project in local.projects :
    flatten([for variable_set_key, variable_set in project.tfc_variable_sets :
      merge(
        variable_set,
        {
          name     = "${project_key} - ${variable_set_key}"
          projects = [project_key]
        }
      )
    ]) if try(project.tfc_variable_sets, null) != null
  ])

  # The following locals use logic to determine the variable sets at workspace level.
  tfc_workspace_level_variable_sets = flatten([for project_key, project in local.projects :
    flatten([for component_key, component in project.components :
      flatten([for variable_set_key, variable_set in component.tfc_variable_sets :
        merge(
          variable_set,
          {
            name       = "${component_key} - ${variable_set_key}"
            workspaces = [component_key]
          }
        )
      ]) if try(component.variable_sets, null) != null
    ]) if try(project.components, null) != null
  ])

  # This is to concat all variable sets.
  tfc_variable_sets = concat(
    local.tfc_organization_level_variable_sets,
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