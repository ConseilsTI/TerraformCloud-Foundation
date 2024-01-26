locals {

  # The following locals use logic to determine the teams at organization level.
  organization_level_teams = flatten([for team_key, team in local.organization_teams :
    merge(
      team,
      {
        name = lower(team_key)
      }
    )
  ])

  # The following locals use logic to determine the project associate with each team.
  project_level_teams = flatten([for project_key, project in local.projects :
    flatten([for team_key, team in project.teams :
      merge(
        team,
        { name    = lower("${project_key}-${team_key}")
          project = project_key
        }
      )
    ])
    if try(project.teams, null) != null
  ])

  # The following locals use logic to determine the workspace associate with each team.
  workspace_level_teams = flatten([for project_key, project in local.projects :
    flatten([for workspace_key, workspace in project.workspaces :
      flatten([for team_key, team in workspace.teams :
        merge(
          team,
          { name      = lower("${workspace_key}-${team_key}")
            workspace = workspace_key
          }
        )
      ])
      if try(workspace.teams, null) != null
    ])
    if try(project.workspaces, null) != null
  ])

  # This is to concat organization teams with project teams.
  teams = concat(
    local.organization_level_teams,
    local.project_level_teams,
    local.workspace_level_teams
  )

}
