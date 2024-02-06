locals {

  # The following locals use logic to determine the variable sets at organization level.
  organization_level_variable_sets = flatten([for variable_set_key, variable_set in local.organization_variable_sets :
    merge(
      variable_set,
      {
        name = variable_set_key
      }
    )
  ])

  # The following locals use logic to determine the variable sets at project level.
  project_level_variable_sets = flatten([for project_key, project in local.projects :
    flatten([for variable_set_key, variable_set in project.variable_sets :
      merge(
        variable_set,
        {
          name     = "${project_key} - ${variable_set_key}"
          projects = [project_key]
        }
      )
    ])
    if try(project.variable_sets, null) != null
  ])

  # The following locals use logic to determine the variable sets at workspace level.
  workspace_level_variable_sets = flatten([for project_key, project in local.projects :
    flatten([for workspace_key, workspace in project.workspaces :
      flatten([for variable_set_key, variable_set in workspace.variable_sets :
        merge(
          variable_set,
          {
            name       = "${workspace_key} - ${variable_set_key}"
            workspaces = [workspace_key]
          }
        )
      ])
      if try(workspace.variable_sets, null) != null
    ])
    if try(project.workspaces, null) != null
  ])

  # This is to concat all variable sets.
  variable_sets = concat(
    local.organization_level_variable_sets,
    local.project_level_variable_sets,
    local.workspace_level_variable_sets
  )

  # The following locals use logic to determine the project associated to a variable sets.
  project_variable_sets = flatten([for variable_set in local.variable_sets :
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
  workspace_variable_sets = flatten([for variable_set in local.variable_sets :
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