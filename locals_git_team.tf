# The following locals use logic to determine the repository associate with each team.

locals {

  git_teams = flatten([for project_key, project in local.projects :
    flatten([for factory_key, factory in project.factories :
      flatten([for team in factory.git_teams :
        merge(
          team,
          {
            repository = factory_key
          }
        )
      ]) if try(factory.git_teams, null) != null
    ]) if try(project.factories, null) != null
  ])

}
