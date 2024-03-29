locals {

  # The following locals use logic to determine the project associate with each team.
  tfc_project_teams = flatten([for project_key, project in local.projects :
    flatten([for team in project.tfc_teams :
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
    flatten([for factory_key, factory in project.factories :
      flatten([for team in factory.tfc_teams :
        merge(
          team,
          {
            workspace = factory_key
          }
        )
      ])
      if try(factory.tfc_teams, null) != null
    ])
    if try(project.factories, null) != null
  ])

  # This is to concat organization teams with project teams and workspace teams.
  tfc_teams = concat(
    local.tfc_organization_teams,
    local.tfc_project_teams,
    local.tfc_workspace_teams
  )

  # The following locals use logic to determine the required members. 
  tfc_teams_members = flatten([for team in local.tfc_teams :
    flatten([for member in team.members :
      member
    ]) if try(team.members, null) != null
  ])
}