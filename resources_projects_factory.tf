# The following code block is used to create GitHub repository resources.

module "projects_factory_repository" {
  source = "./modules/github_repository"

  name                   = "TerraformCloud-ProjectOnboarding"
  description            = "Repository to provision and manage Terraform Cloud projects using Terraform code (IaC)."
  visibility             = "public"
  delete_branch_on_merge = true
  auto_init              = true
  security_and_analysis = {
    # advanced_security = {
    #   status = try(each.value.github_repository.security_and_analysis.advanced_security.status, null)
    # }
    secret_scanning = {
      status = "enabled"
    }
    secret_scanning_push_protection = {
      status = "enabled"
    }
  }
  vulnerability_alerts = true
  allow_update_branch  = false

  branch_protections = [
    {
      pattern                         = "main"
      enforce_admins                  = true
      require_signed_commits          = false
      required_linear_history         = false
      require_conversation_resolution = true
      required_status_checks          = null
      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        restrict_dismissals             = null
        dismissal_restrictions          = null
        pull_request_bypassers          = null
        require_code_owner_reviews      = true
        required_approving_review_count = "0"
        require_last_push_approval      = false
      }
      push_restrictions    = null
      force_push_bypassers = null
      allows_deletions     = false
      allows_force_pushes  = false
      blocks_creations     = false
      lock_branch          = false
    }
  ]
}

# The following code block is used to create workspace resources in project.

module "projects_factory_workspaces" {
  source = "./modules/tfe_workspace"

  name              = "TerraformCloud-ProjectOnboarding"
  organization      = data.tfe_organization.this.name
  project_id        = tfe_project.project["Terraform Cloud"].id
  description       = "Repository to provision and manage Terraform Cloud projects using Terraform code (IaC)."
  tag_names         = ["managed_by_terraform"]
  terraform_version = "latest"
  trigger_patterns  = ["*.tf"]
  vcs_repo = {
    identifier     = "${local.git_organization_name}/TerraformCloud-ProjectOnboarding"
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
  depends_on = [module.projects_factory_repository]
}

# The following code block is used to create notification resources in project.

module "projects_factory_notifications" {
  source = "./modules/tfe_notification"

  name             = "Microsoft Teams"
  destination_type = "microsoft-teams"
  workspace_id     = module.projects_factory_workspaces.id
  enabled          = true
  triggers         = ["run:created", "run:planning", "run:needs_attention", "run:applying", "run:completed", "run:errored", "assessment:check_failure", "assessment:drifted", "assessment:failed"]
  url              = "https://conseilsti.webhook.office.com/webhookb2/b1967add-a0bb-4f55-9508-280cefef4403@0f9829d3-a628-4f2b-a3ac-58e0740d27ae/IncomingWebhook/bd56b2570de84870b0529487428b9ccb/4c88f00c-bcb7-4867-823f-ce6d94fb1c06"
}
