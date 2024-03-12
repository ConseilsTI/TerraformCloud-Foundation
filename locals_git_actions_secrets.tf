# The following locals use logic to determine the actions secrets associate with each GitHub repository.

locals {

  git_actions_secrets = flatten([for project_key, project in local.projects :
    flatten([for factory_key, factory in project.factories :
      flatten([for git_actions_secret in factory.git_actions_secrets :
        merge(
          git_actions_secret,
          {
            key        = lower("${factory_key}-${git_actions_secret.secret_name}")
            repository = factory_key
          }
        )
      ]) if try(factory.git_actions_secrets, null) != null
    ]) if try(project.factories, null) != null
  ])

}
