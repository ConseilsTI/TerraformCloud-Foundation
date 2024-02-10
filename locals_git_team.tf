# The following locals use logic to determine the repository associate with each team.

locals {

  git_teams = flatten([for project_key, project in local.projects :
    flatten([for component_key, component in project.components :
      flatten([for team in component.git_teams : 
        merge(
          team,
          {
            repository = component_key
          }
        )
      ]) if try(component.git_teams, null) != null
    ]) if try(project.components, null) != null
  ])

}
