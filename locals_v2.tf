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
}

output "repositories" {
  value = local.repositories
}