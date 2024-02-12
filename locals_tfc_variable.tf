locals {

  # The following locals use logic to determine the variable associated to a variable sets.
  tfc_variable_sets_variables = flatten([for variable_set in local.tfc_variable_sets :
    flatten([for variable in variable_set.variables :
      merge(
        variable,
        {
          variable_set = variable_set.name
        }
      )
    ]) if try(variable_set.variables, null) != null
  ])

  # The following locals use logic to determine the variable associated to a workspace.
  tfc_workspace_variables = flatten([for project_key, project in local.projects :
    flatten([for component_key, component in project.components :
      flatten([for variable_key, variable in component.tfc_variables :
        merge(
          variable,
          {
            workspace = component_key
          }
        )
      ]) if try(component.tfc_variables, null) != null
    ]) if try(project.components, null) != null
  ])

}