locals {
  directories = {
    "foundation" = {
      workspaces = {
        "test" = {
          description = "this is a test."
          tfc_workspace = {
            vcs_repo = true
          }
          tfc_teams = {
            "contributor" = {
              token = true
              organization_access = {
                manage_modules = true
              }
              workspace_permission = {
                runs = "apply"
              }
            }
          }
          git_repository = {
            topics = ["factory"]
          }
        }
        "test2" = {
          description = "this is a test."
          tfc_workspace = {
            vcs_repo = true
          }
          tfc_teams = {
            "contributor" = {
              token = true
              organization_access = {
                manage_modules = true
              }
              workspace_permission = {
                runs = "apply"
              }
            }
          }
        }
      }
    }
  }
}

locals {

  # This local is use to determin each required GitHub repository.
  repositories = flatten([for directory_key, directory in local.directories :
    flatten([for workspace_key, workspace in directory.workspaces :
      merge(
        workspace.git_repository,
        { name        = workspace_key
          description = workspace.description
        }
      ) if try(workspace.git_repository, null) != null
    ])
    if try(directory.workspaces, null) != null
  ])

  # The following locals use logic to determine the project associate with each workspace.
  v2_workspaces = flatten([for directory_key, directory in local.directories :
    flatten([for workspace_key, workspace in directory.workspaces :
      merge(
        workspace.tfc_workspace,
        { name        = workspace_key
          description = workspace.description
        project = projects }
      ) if try(workspace.tfc_workspace, null) != null
    ])
    if try(project.workspaces, null) != null
  ])

}

output "repositories" {
  value = local.repositories
}

output "v2_workspaces" {
  value = local.v2_workspaces
}