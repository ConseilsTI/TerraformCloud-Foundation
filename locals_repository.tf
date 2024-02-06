locals {

  # This local is use to determin each required GitHub repository.
  repositories = flatten([for project_key, project in local.projects :
    flatten([for workspace_key, workspace in project.workspaces :
      merge(
        workspace.git_repository,
        { name        = workspace_key
          description = workspace.description
        }
      ) if try(workspace.git_repository, null) != null
    ])
    if try(project.workspaces, null) != null
  ])

}

output "repositories" {
  value = local.repositories
}