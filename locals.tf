locals {
  # This local is used to define the organization name.
  organization_name = "ConseilsTI"

  # This local is used to define Oauth_client name.
  oauth_client_name = "GitHub.com"

  # This local is used to define all required secrets that we have to read from Hashicorp Vault Secrets.
  secrets = {
    aws_access_key_id = {
      project = "AWS"
    }
    aws_secret_access_key = {
      project = "AWS"
    }
    arm_client_id = {
      project = "Azure"
    }
    arm_client_secret = {
      project = "Azure"
    }
    github_app_id = {
      project = "GitHub"
    }
    github_app_installation_id = {
      project = "GitHub"
    }
    github_app_pem_file = {
      project = "GitHub"
    }
  }

  # This local is used to define teams at the organization level.
  organization_teams = {
    # `organization_teams` is a map of object where the key is the name of the team.
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
  organization_variable_sets = {
    # `organization_variable_sets` is a map of object where the key is the name of the variable_set.
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
    # Each project can contain all required object like teams, variable sets, workspaces, variables...
    # Refer to "./modules/workspace/README.md" for more details on the workspace properties.
    # Refer to "./modules/team/README.md" for more details on the permissions type.
    # Refer to "./modules/notification/README.md" for more details on the notification configuration.
    # Here is an example of an object:
    # "project_name" = {
    #   agent_pools = [""]
    #   teams = {
    #     "team_name" = {
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
    #       token_expired_at       = ""
    #       token_force_regenerate = true or false
    #       visibility             = "secret" or "organization"
    #     }
    #   }
    #   variable_set = {
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
    #   workspaces = {
    #     "workspace_name" = {
    #       description       = ""
    #       github_repository = {
    #         actions_secrets = [
    #           {
    #             secret_name     = ""
    #             plaintext_value = ""
    #           }
    #         ]
    #       }
    #       notifications = {
    #         "notification_name" = {
    #           destination_type = "generic", "email", "email", or "microsoft-teams"
    #           triggers         = ["run:created", "run:planning", "run:needs_attention", "run:applying", "run:completed", "run:errored", "assessment:check_failure", "assessment:drifted", "assessment:failed"]
    #           url              = "Url
    #         }
    #       }
    #       tag_names = [""]
    #       teams = {
    #         "team_name" = {
    #           workspace_permission = {
    #             runs              = "read", "plan", or "apply"
    #             variables         = "none", "read", or "write"
    #             state_versions    = "none", "read", "read-outputs", or "write"
    #             sentinel_mocks    = "none" or "read"
    #             workspace_locking = true or false
    #             run_tasks         = true or false
    #           }
    #           members = []
    #           sso_team_id            = ""
    #           token                  = true or false
    #           token_expired_at       = ""
    #           token_force_regenerate = true or false
    #           visibility             = "secret" or "organization"
    #         }
    #       }
    #       trigger_patterns = [""]
    #       variables = {
    #         "variable_name" = {
    #           value     = ""
    #           category  = "terraform" or "env"
    #           sensitive = true or false
    #         }
    #       }
    #       vcs_repo = {
    #         identifier     = "GitHub repository"
    #         oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
    #       }
    #     }
    #   }
    # }
    "Azure Landing Zone" = {
      agent_pools = ["azure"]
      workspaces = {
        "Azure-OIDC-TerraformCloud" = {
          description               = "Repository to provision and manage Azure OIDC configuration through Terraform code (IaC)."
          remote_state_consumer_ids = ["TerraformCloud-Foundation"]
          notifications = {
            "Microsoft Teams" = {
              destination_type = "microsoft-teams"
              triggers         = ["run:created", "run:planning", "run:needs_attention", "run:applying", "run:completed", "run:errored", "assessment:check_failure", "assessment:drifted", "assessment:failed"]
              url              = "https://conseilsti.webhook.office.com/webhookb2/b1967add-a0bb-4f55-9508-280cefef4403@0f9829d3-a628-4f2b-a3ac-58e0740d27ae/IncomingWebhook/bd56b2570de84870b0529487428b9ccb/4c88f00c-bcb7-4867-823f-ce6d94fb1c06"
            }
          }
          tag_names        = ["managed_by_terraform"]
          trigger_patterns = ["*.tf"]
          vcs_repo = {
            identifier     = "benyboy84/Azure-OIDC-TerraformCloud"
            oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
          }
          variables = {
            "ARM_CLIENT_ID" = {
              value     = data.hcp_vault_secrets_secret.this["arm_client_id"].secret_value
              category  = "env"
              sensitive = true
            }
            "ARM_CLIENT_SECRET" = {
              value     = data.hcp_vault_secrets_secret.this["arm_client_secret"].secret_value
              category  = "env"
              sensitive = true
            }
          }
        }
        "Azure-Enterprise" = {
          notifications = {
            "Microsoft Teams" = {
              destination_type = "microsoft-teams"
              triggers         = ["run:created", "run:planning", "run:needs_attention", "run:applying", "run:completed", "run:errored", "assessment:check_failure", "assessment:drifted", "assessment:failed"]
              url              = "https://conseilsti.webhook.office.com/webhookb2/b1967add-a0bb-4f55-9508-280cefef4403@0f9829d3-a628-4f2b-a3ac-58e0740d27ae/IncomingWebhook/bd56b2570de84870b0529487428b9ccb/4c88f00c-bcb7-4867-823f-ce6d94fb1c06"
            }
          }
          tag_names        = ["managed_by_terraform"]
          trigger_patterns = ["*.tf"]
          vcs_repo = {
            identifier     = "benyboy84/Azure-Enterprise"
            oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
          }
          variables = {
            "TFC_AZURE_RUN_CLIENT_ID" = {
              value     = data.hcp_vault_secrets_secret.this["arm_client_id"].secret_value
              category  = "env"
              sensitive = true
            }
            "TFC_AZURE_PROVIDER_AUTH" = {
              value     = "true"
              category  = "env"
              sensitive = true
            }
          }
        }
      }
    }
    "AWS Landing Zone" = {
      workspaces = {
        "AWS-OIDC-TerraformCloud" = {
          description               = "Repository to provision and manage AWS OIDC configuration through Terraform code (IaC)."
          remote_state_consumer_ids = ["TerraformCloud-Foundation"]
          notifications = {
            "Microsoft Teams" = {
              destination_type = "microsoft-teams"
              triggers         = ["run:created", "run:planning", "run:needs_attention", "run:applying", "run:completed", "run:errored", "assessment:check_failure", "assessment:drifted", "assessment:failed"]
              url              = "https://conseilsti.webhook.office.com/webhookb2/b1967add-a0bb-4f55-9508-280cefef4403@0f9829d3-a628-4f2b-a3ac-58e0740d27ae/IncomingWebhook/bd56b2570de84870b0529487428b9ccb/4c88f00c-bcb7-4867-823f-ce6d94fb1c06"
            }
          }
          tag_names        = ["managed_by_terraform"]
          trigger_patterns = ["*.tf"]
          vcs_repo = {
            identifier     = "benyboy84/AWS-OIDC-TerraformCloud"
            oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
          }
          variables = {
            "AWS_ACCESS_KEY_ID" = {
              value     = data.hcp_vault_secrets_secret.this["aws_access_key_id"].secret_value
              category  = "env"
              sensitive = true
            }
            "AWS_SECRET_ACCESS_KEY" = {
              value     = data.hcp_vault_secrets_secret.this["aws_secret_access_key"].secret_value
              category  = "env"
              sensitive = true
            }
          }
        }
      }
    }
    "AWS Workloads" = {
      teams = {
        "plan" = {
          custom_workspace_access = {
            runs = "plan"
          }
          project_access = "custom"
          token          = true
          visibility     = "organization"
        }
      }
      variable_sets = {
        "Authentication" = {
          description = "Dynamic credentials for AWS workload"
          global      = false
          variables = {
            "TFC_AWS_PROVIDER_AUTH" = {
              value     = "true"
              category  = "env"
              sensitive = false
            }
            "TFC_AWS_RUN_ROLE_ARN" = {
              value     = data.terraform_remote_state.aws-oidc-terraformcloud.outputs.arn
              category  = "env"
              sensitive = true
            }
          }
        }
      }
      workspaces = {
        "AWS_S3" = {
          description = "Repository to provision and manage AWS S3 configuration through Terraform code (IaC)."
          github_repository = {
            actions_secrets = [
              {
                secret_name     = "TF_API_TOKEN"
                plaintext_value = "aws workloads-plan"
              }
            ]
          }
          notifications = {
            "Microsoft Teams" = {
              destination_type = "microsoft-teams"
              triggers         = ["run:created", "run:planning", "run:needs_attention", "run:applying", "run:completed", "run:errored", "assessment:check_failure", "assessment:drifted", "assessment:failed"]
              url              = "https://conseilsti.webhook.office.com/webhookb2/b1967add-a0bb-4f55-9508-280cefef4403@0f9829d3-a628-4f2b-a3ac-58e0740d27ae/IncomingWebhook/bd56b2570de84870b0529487428b9ccb/4c88f00c-bcb7-4867-823f-ce6d94fb1c06"
            }
          }
          tag_names = ["managed_by_terraform"]
        }
      }
    }
    "Terraform Cloud" = {
      workspaces = {
        "TerraformCloud-ModulesRegistry" = {
          description = "Repository to provision and manage Terraform Cloud modules registry using Terraform code (IaC)."
          notifications = {
            "Microsoft Teams" = {
              destination_type = "microsoft-teams"
              triggers         = ["run:created", "run:planning", "run:needs_attention", "run:applying", "run:completed", "run:errored", "assessment:check_failure", "assessment:drifted", "assessment:failed"]
              url              = "https://conseilsti.webhook.office.com/webhookb2/b1967add-a0bb-4f55-9508-280cefef4403@0f9829d3-a628-4f2b-a3ac-58e0740d27ae/IncomingWebhook/bd56b2570de84870b0529487428b9ccb/4c88f00c-bcb7-4867-823f-ce6d94fb1c06"
            }
          }
          tag_names = ["managed_by_terraform"]
          teams = {
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
          trigger_patterns = ["*.tf"]
          variables = {
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
          }
          vcs_repo = {
            identifier     = "benyboy84/TerraformCloud-ModulesRegistry"
            oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
          }
        }
        "TerraformCloud-Policies" = {
          description = "Repository to provision and manage Terraform Cloud policies using Terraform code (IaC)."
          notifications = {
            "Microsoft Teams" = {
              destination_type = "microsoft-teams"
              triggers         = ["run:created", "run:planning", "run:needs_attention", "run:applying", "run:completed", "run:errored", "assessment:check_failure", "assessment:drifted", "assessment:failed"]
              url              = "https://conseilsti.webhook.office.com/webhookb2/b1967add-a0bb-4f55-9508-280cefef4403@0f9829d3-a628-4f2b-a3ac-58e0740d27ae/IncomingWebhook/bd56b2570de84870b0529487428b9ccb/4c88f00c-bcb7-4867-823f-ce6d94fb1c06"
            }
          }
          tag_names = ["managed_by_terraform"]
          teams = {
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
          trigger_patterns = ["*.tf", "*.sentinel"]
          variables = {
            "TFE_TOKEN" = {
              value     = "terraformcloud-policies-manage-policies"
              category  = "env"
              sensitive = true
            }
          }
          vcs_repo = {
            identifier     = "benyboy84/TerraformCloud-Policies"
            oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
          }
        }
      }
    }
  }

}