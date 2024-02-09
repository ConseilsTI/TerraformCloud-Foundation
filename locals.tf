locals {
  # This local is used to define the organization name.
  tfc_organization_name = "ConseilsTI"

  # This local is used to define Oauth_client name.
  tfc_oauth_client_name = "GitHub.com (ConseilsTI)"

  # This local is used to define GitHub organization name.
  git_organization_name = "ConseilsTI"

  # This local is used to define all required secrets that we have to read from Hashicorp Vault Secrets.
  hcp_vault_secrets = {
    github_app_id = {
      project = "GitHub"
    }
    github_app_installation_id = {
      project = "GitHub"
    }
    github_app_pem_file = {
      project = "GitHub"
    }
    github_owner = {
      project = "GitHub"
    }
  }

  # This local is used to define teams at the organization level.
  tfc_organization_teams = {
    # `tfc_organization_teams` is a map of object where the key is the name of the team.
    # Each object must contain an `organization_access` argument with the team's organization access.
    # Refer to "./modules/team/README.md" for more details on the permissions type.
    # Here is an example of an object:
    # "team_name" = {
    #   members = []
    #   organization_access = {
    #     read_projects           = true or false
    #     manage_projects         = true or false
    #     read_workspaces         = true or false
    #     manage_workspaces       = true or false
    #     manage_policies         = true or false
    #     manage_policy_overrides = true or false
    #     manage_run_tasks        = true or false
    #     manage_vcs_settings     = true or false
    #     manage_membership       = true or false
    #     manage_modules          = true or false
    #     manage_providers        = true or false
    #   }
    #   sso_team_id            = ""
    #   token                  = true or false
    #   token_expired_at       = ""
    #   token_force_regenerate = true or false
    #   visibility             = "secret" or "organization"
    # }
    "admins" = {
      sso_team_id = "a2f4919a-4c3c-436a-a010-fde47b98d0fd"
      token       = true
      organization_access = {
        manage_projects         = true
        manage_workspaces       = true
        manage_policies         = true
        manage_policy_overrides = true
        manage_run_tasks        = true
        manage_vcs_settings     = true
        manage_membership       = true
        manage_modules          = true
        manage_providers        = true
      }
    },
  }

  # This local is used to define variable_set at the organization level.
  tfc_organization_variable_sets = {
    # `tfc_organization_variable_sets` is a map of object where the key is the name of the variable_set.
    # Here is an example of an object:
    # "name" = {
    #   description = ""
    #   global      = true or false *Cannot be set to true if `workspaces` or ``projects` are defined.*
    #   projects    = [""]
    #   variables = {
    #     variable_name = {
    #       value     = ""
    #       category  = "terraform" or "env"
    #       sensitive = true or false
    #     }
    #   }
    #   workspaces  = [""]
    # }
  }

  # This local is used to define all resrouces required to deploy IaC in Terraform Cloud. 
  projects = {
    # `projects` is a map of object where the key is the name of the project.
    # Each project can contain all required object like teams, variable sets, workspaces, variables, GitHub, GitHub Teams...
    # Refer to "./modules/tfe_workspace/README.md" for more details on the workspace properties.
    # Refer to "./modules/tfe_team/README.md" for more details on the permissions type.
    # Refer to "./modules/tfe_notification/README.md" for more details on the notification configuration.
    # Refer to "./modules/git_repository/README.md" for more details on the GitHub repository configuration.
    # Refer to "./modules/git_team/README.md" for more details on the GitHub team configuration.
    # Here is an example of an object:
    # "project_name" = {
    #   components = {
    #    "component_key" = {  # This will be use for the Terraform Cloud workspace name and GitHub repository name
    #      description = "" # This will be use for the Terraform Cloud workspace name and GitHub repository name
    #      git_repository = {
    #        topics = [""]
    #      }
    #      git_teams = {
    #        "team_name" = {
    #          description = ""
    #          permission  = ""
    #        }
    #      }
    #      tfc_notifications = {
    #        "notification_name" = {
    #          destination_type = "generic", "email", "email", or "microsoft-teams"
    #          triggers         = ["run:created", "run:planning", "run:needs_attention", "run:applying", "run:completed", "run:errored", "assessment:check_failure", "assessment:drifted", "assessment:failed"]
    #          url              = ""
    #        }
    #      }
    #      tfc_teams = {
    #        "team_name" = {
    #          workspace_permission = {
    #            runs              = "read", "plan", or "apply"
    #            variables         = "none", "read", or "write"
    #            state_versions    = "none", "read", "read-outputs", or "write"
    #            sentinel_mocks    = "none" or "read"
    #            workspace_locking = true or false
    #            run_tasks         = true or false
    #          }
    #          members = []
    #          sso_team_id            = ""
    #          token                  = true or false
    #          visibility             = "secret" or "organization"
    #        }
    #      }
    #      tfc_workspace = {
    #        agent_pool       = ""
    #        execution_mode   = "null", "remote", "local", "agent"
    #        tag_names        = [""]
    #        trigger_patterns = [""]
    #        vcs_repo         = true or false
    #      }
    #      tfc_variable_sets = {
    #        "variable_set_name" = {
    #          description = ""
    #          global      = false *Cannot be set to true.*
    #          variables = {
    #            "variable_name" = {
    #              value     = ""
    #              category  = "terraform" or "env"
    #              sensitive = true or false
    #            }
    #          }
    #        }
    #      }
    #      tfc_variables = {
    #        "variable_name" = {
    #          value     = ""
    #          category  = "terraform" or "env"
    #          sensitive = true or false
    #        }
    #      }
    #    }
    #   tfc_teams = {
    #     "team_name" = {
    #       project_access = "admin", "maintain", "write", "read", "custom"
    #       custom_project_access = {
    #         settings = "read", "update", "delete"
    #         teams    = "none", "read", "manage"
    #       }
    #       custom_workspace_access = {
    #         runs           = "read", "plan", or "apply"
    #         sentinel_mocks = "none", or "read"
    #         state_versions = "none", "read-outputs", "read", or "write"
    #         variables      = "none", "read", or "write"
    #         create         = true or false
    #         locking        = true or false
    #         delete         = true or false
    #         move           = true or false
    #         run_tasks      = true or false
    #       }
    #       members = []
    #       sso_team_id            = ""
    #       token                  = true or false
    #       visibility             = "secret" or "organization"
    #     }
    #   }
    #   tfc_variable_sets = {
    #     "name" = {
    #       description = ""
    #       global      = false *Cannot be set to true.*
    #       variables = {
    #         variable_name = {
    #           value     = ""
    #           category  = "terraform" or "env"
    #           sensitive = true or false
    #         }
    #       }
    #       workspaces  = [""]
    #     }
    #   }
    # }

    "Terraform Cloud" = {
      components = {
        "TerraformCloud-ModulesRegistry" = {
          description = "Repository to provision and manage Terraform Cloud modules registry using Terraform code (IaC)."
          git_repository = {
            topics = ["foundation", "factory"]
          }
          git_teams = {
            "contributor" = {
              description = "This group grant write access to the ModulesRegistry repository."
              permission  = "push"
            }
          }
          tfc_notifications = {
            "Microsoft Teams" = {
              destination_type = "microsoft-teams"
              triggers         = ["run:created", "run:planning", "run:needs_attention", "run:applying", "run:completed", "run:errored", "assessment:check_failure", "assessment:drifted", "assessment:failed"]
              url              = "https://conseilsti.webhook.office.com/webhookb2/b1967add-a0bb-4f55-9508-280cefef4403@0f9829d3-a628-4f2b-a3ac-58e0740d27ae/IncomingWebhook/bd56b2570de84870b0529487428b9ccb/4c88f00c-bcb7-4867-823f-ce6d94fb1c06"
            }
          }
          tfc_teams = {
            "manage-modules" = {
              sso_team_id = "a1f6c183-1350-4298-9266-b1ba00c66372"
              token       = true
              organization_access = {
                manage_modules = true
              }
              workspace_permission = {
                runs = "apply"
              }
            }
          }
          tfc_workspace = {
            tag_names                 = ["foundation", "factory"]
            trigger_patterns          = ["*.tf"]
            vcs_repo                  = true
          }
          tfc_variables = {
            "TFE_TOKEN" = {
              value     = "terraformcloud-modulesregistry-manage-modules"
              category  = "env"
              sensitive = true
            }
            "GITHUB_APP_ID" = {
              value     = data.hcp_vault_secrets_secret.this["github_app_id"].secret_value
              category  = "env"
              sensitive = true
            }
            "GITHUB_APP_INSTALLATION_ID" = {
              value     = data.hcp_vault_secrets_secret.this["github_app_installation_id"].secret_value
              category  = "env"
              sensitive = true
            }
            "GITHUB_APP_PEM_FILE" = {
              value     = data.hcp_vault_secrets_secret.this["github_app_pem_file"].secret_value
              category  = "env"
              sensitive = true
            }
            "GITHUB_OWNER" = {
              value     = data.hcp_vault_secrets_secret.this["github_owner"].secret_value
              category  = "env"
              sensitive = true
            }
          }
        }
        "TerraformCloud-Policies" = {
          description = "Repository to provision and manage Terraform Cloud policies using Terraform code (IaC)."
          git_repository = {
            topics = ["foundation", "factory"]
          }
          git_teams = {
            "contributor" = {
              description = "This group grant write access to the ModulesRegistry repository."
              permission  = "push"
            }
          }
          tfc_notifications = {
            "Microsoft Teams" = {
              destination_type = "microsoft-teams"
              triggers         = ["run:created", "run:planning", "run:needs_attention", "run:applying", "run:completed", "run:errored", "assessment:check_failure", "assessment:drifted", "assessment:failed"]
              url              = "https://conseilsti.webhook.office.com/webhookb2/b1967add-a0bb-4f55-9508-280cefef4403@0f9829d3-a628-4f2b-a3ac-58e0740d27ae/IncomingWebhook/bd56b2570de84870b0529487428b9ccb/4c88f00c-bcb7-4867-823f-ce6d94fb1c06"
            }
          }
          tfc_teams = {
            "manage-policies" = {
              sso_team_id = "045981aa-f630-44c4-88fe-a0b992a2a94e"
              token       = true
              organization_access = {
                manage_policies = true
              }
              workspace_permission = {
                runs = "apply"
              }
            }
          }
          tfc_workspace = {
            tag_names        = ["foundation", "factory"]
            trigger_patterns = ["*.tf", "*.hcl", "*.sentinel"]
            vcs_repo         = true
          }
          tfc_variables = {
            "TFE_TOKEN" = {
              value     = "terraformcloud-policies-manage-policies"
              category  = "env"
              sensitive = true
            }
          }
        }
        # "TerraformCloud-Projects" = {
        #   description = "Repository to provision and manage Terraform Cloud projects using Terraform code (IaC)."
        #   tfc_workspace = {
        #     agent_pool       = "foundation"
        #     tag_names        = ["foundation", "factory"]
        #     trigger_patterns = ["*.tf"]
        #     vcs_repo         = true
        #   }
        #   tfc_notifications = {
        #     "Microsoft Teams" = {
        #       destination_type = "microsoft-teams"
        #       triggers         = ["run:created", "run:planning", "run:needs_attention", "run:applying", "run:completed", "run:errored", "assessment:check_failure", "assessment:drifted", "assessment:failed"]
        #       url              = "https://conseilsti.webhook.office.com/webhookb2/b1967add-a0bb-4f55-9508-280cefef4403@0f9829d3-a628-4f2b-a3ac-58e0740d27ae/IncomingWebhook/bd56b2570de84870b0529487428b9ccb/4c88f00c-bcb7-4867-823f-ce6d94fb1c06"
        #     }
        #   }
        #   tfc_teams = {
        #     "contributor" = {
        #       workspace_permission = {
        #         runs = "apply"
        #       }
        #     }
        #   }
        #   git_repository = {
        #     topics = ["foundation", "factory"]
        #   }
        #   git_teams = {
        #     "contributor" = {
        #       description = "This group grant write access to the ModulesRegistry repository."
        #       permission  = "push"
        #     }
        #   }
        # }
      }
    }
  }
}
