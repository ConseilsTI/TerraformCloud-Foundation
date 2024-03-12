# This local is use to determin each required GitHub repository.

locals {

  git_repositories = flatten([for project_key, project in local.projects :
    flatten([for factory_key, factory in project.factories :
      merge(
        factory.git_repository,
        {
          name        = factory_key
          description = factory.description
        }
      ) if try(factory.git_repository, null) != null
    ]) if try(project.factories, null) != null
  ])

}