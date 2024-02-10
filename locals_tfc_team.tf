locals {

  # The following locals use logic to determine the project associate with each team.
  tfc_project_teams = flatten([for project_key, project in local.projects :
    flatten([for team_key, team in project.tfc_teams :
      merge(
        team,
        {
          project = project_key
        }
      )
    ]) if try(project.tfc_teams, null) != null
  ])

  # The following locals use logic to determine the workspace associate with each team.
  tfc_workspace_teams = flatten([for project_key, project in local.projects :
    flatten([for component_key, component in project.components :
      flatten([for team_key, team in component.tfc_teams :
        merge(
          team,
          {
            workspace = component_key
          }
        )
      ])
      if try(component.tfc_teams, null) != null
    ])
    if try(project.components, null) != null
  ])

  # This is to concat organization teams with project teams and workspace teams.
  tfc_teams = concat(
    local.tfc_organization_teams,
    local.tfc_project_teams,
    local.tfc_workspace_teams
  )

}