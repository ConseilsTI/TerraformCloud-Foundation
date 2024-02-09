# The following locals use logic to determine the actions secrets associate with each GitHub repository.

locals {

  git_actions_secrets = nonsensitive(flatten([for project_key, project in local.projects :
    flatten([for component_key, component in project.components :
      flatten([for git_actions_secret in component.git_actions_secrets :
        merge(
          git_actions_secret,
          {
            key        = lower("${component_key}-${git_actions_secret.secret_name}")
            repository = component_key
          }
        )
      ]) if try(component.git_actions_secrets, null) != null
    ]) if try(project.components, null) != null
  ]))

}

output "git_actions_secrets" {
  value = local.git_actions_secrets
}