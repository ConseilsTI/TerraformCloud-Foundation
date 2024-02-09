# The following locals use logic to determine the repository associate with each team.

locals {

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
      ]) if try(workspace.git_teams, null) != null
    ]) if try(project.workspaces, null) != null
  ])

  git_teams = concat(
    local.git_repository_level_teams,
  )

}
