locals {

  # The following locals use logic to determine the teams at organization level.
  tfc_organization_level_teams = flatten([for team_key, team in local.tfc_organization_teams :
    merge(
      team,
      {
        name = lower(team_key)
      }
    )
  ])

  # The following locals use logic to determine the project associate with each team.
  tfc_project_level_teams = flatten([for project_key, project in local.projects :
    flatten([for team_key, team in project.tfc_teams :
      merge(
        team,
        {
          name    = lower("${project_key} - ${team_key}")
          project = project_key
        }
      )
    ]) if try(project.tfc_teams, null) != null
  ])

  # The following locals use logic to determine the workspace associate with each team.
  tfc_workspace_level_teams = flatten([for project_key, project in local.projects :
    flatten([for component_key, component in project.components :
      flatten([for team_key, team in component.tfc_teams :
        merge(
          team,
          {
            name      = lower("${component_key}-${team_key}")
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
    local.tfc_organization_level_teams,
    local.tfc_project_level_teams,
    local.tfc_workspace_level_teams
  )

}