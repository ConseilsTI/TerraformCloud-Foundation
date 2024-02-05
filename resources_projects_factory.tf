# # The following code block is used to create GitHub repository resources.

# resource "github_repository" "projects_factory" {

#   name                   = "TerraformCloud-ProjectsFactory"
#   description            = "Repository to provision and manage Terraform Cloud projects using Terraform code (IaC)."
#   visibility             = "public"
#   has_issues             = true
#   has_projects           = true
#   has_wiki               = true
#   delete_branch_on_merge = true
#   auto_init              = true

#   security_and_analysis {
#     # advanced_security {
#     #   status = "enabled"
#     # }
#     secret_scanning {
#       status = "enabled"
#     }
#     secret_scanning_push_protection {
#       status = "enabled"
#     }
#   }

#   topics               = ["terraform-workspace", "terraform", "terraform-managed", "foundation", "factory"]
#   vulnerability_alerts = true
#   allow_update_branch  = false
# }

# resource "github_branch_protection" "projects_factory" {
#   repository_id                   = github_repository.projects_factory.name
#   pattern                         = "main"
#   enforce_admins                  = true
#   require_conversation_resolution = true

#   required_pull_request_reviews {
#     dismiss_stale_reviews           = true
#     require_code_owner_reviews      = true
#     required_approving_review_count = "0"
#   }
# }

# # The following code block is used to create workspace resources in project.

# resource "tfe_workspace" "projects_factory" {

#   name              = github_repository.projects_factory.name
#   description       = github_repository.projects_factory.description
#   organization      = data.tfe_organization.this.name
#   project_id        = tfe_project.project["Terraform Cloud"].id
#   tag_names         = ["managed_by_terraform"]
#   terraform_version = "latest"
#   trigger_patterns  = ["*.tf"]
#   vcs_repo {
#     identifier     = "${local.git_organization_name}/TerraformCloud-ProjectOnboarding"
#     oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
#   }

# }

# # The following code block is used to create notification resources in project.

# module "projects_factory_notifications" {
#   source = "./modules/tfe_notification"

#   name             = "Microsoft Teams"
#   destination_type = "microsoft-teams"
#   workspace_id     = tfe_workspace.projects_factory.id
#   enabled          = true
#   triggers         = ["run:created", "run:planning", "run:needs_attention", "run:applying", "run:completed", "run:errored", "assessment:check_failure", "assessment:drifted", "assessment:failed"]
#   url              = "https://conseilsti.webhook.office.com/webhookb2/b1967add-a0bb-4f55-9508-280cefef4403@0f9829d3-a628-4f2b-a3ac-58e0740d27ae/IncomingWebhook/bd56b2570de84870b0529487428b9ccb/4c88f00c-bcb7-4867-823f-ce6d94fb1c06"
# }
