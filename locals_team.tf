locals {

  # The following locals use logic to determine the teams at organization level.
  tfc_organization_level_teams = flatten([for team_key, team in local.organization_teams :
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
    flatten([for workspace_key, workspace in project.workspaces :
      flatten([for team_key, team in workspace.tfc_teams :
        merge(
          team,
          {
            name      = lower("${workspace_key}-${team_key}")
            workspace = workspace_key
          }
        )
      ])
      if try(workspace.tfc_teams, null) != null
    ])
    if try(project.workspaces, null) != null
  ])

  # This is to concat organization teams with project teams and workspace teams.
  tfc_teams = concat(
    local.tfc_organization_level_teams,
    local.tfc_project_level_teams,
    local.tfc_workspace_level_teams
  )

  # The following locals use logic to determine the repository associate with each team.
  git_repository_level_teams = flatten([for project_key, project in local.projects :
    flatten([for workspace_key, workspace in project.workspaces :
      flatten([for team_key, team in workspace.git_teams :
        merge(
          team,
          {
            name       = lower("${workspace_key}-${team_key}")
            repository = workspace_key
          }
        )
      ]) if try(workspace.github_teams, null) != null
    ]) if try(project.workspaces, null) != null
  ])

  # This is to concat GitHub organization teams with repository teams.
  git_teams = concat(
    local.git_repository_level_teams,
  )

}

output "tfc_teams" {
  value = local.tfc_teams
}

output "git_teams" {
  value = local.git_teams
}