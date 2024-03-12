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
    flatten([for factory_key, factory in project.factories :
      flatten([for variable_key, variable in factory.tfc_variables :
        merge(
          variable,
          {
            workspace = factory_key
          }
        )
      ]) if try(factory.tfc_variables, null) != null
    ]) if try(project.factories, null) != null
  ])

}