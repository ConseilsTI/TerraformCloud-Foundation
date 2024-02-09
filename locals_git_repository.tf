# This local is use to determin each required GitHub repository.

locals {

  git_repositories = flatten([for project_key, project in local.projects :
    flatten([for component_key, component in project.components :
      merge(
        component.git_repository,
        {
          name        = component_key
          description = component.description
        }
      ) if try(component.git_repository, null) != null
    ]) if try(project.components, null) != null
  ])

}