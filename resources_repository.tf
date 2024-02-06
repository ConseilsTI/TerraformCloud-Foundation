module "repository" {
  source = "./modules/github_repository"

  for_each = nonsensitive({ for repository in local.repositories : repository.name => repository })

  name                        = each.value.name
  description                 = try(each.value.description, null)
  homepage_url                = try(each.value.homepage_url, null)
  visibility                  = try(each.value.visibility, "public")
  has_issues                  = try(each.value.has_issues, true)
  has_discussions             = try(each.value.has_discussions, false)
  has_projects                = try(each.value.has_projects, true)
  has_wiki                    = try(each.value.has_wiki, true)
  is_template                 = try(each.value.is_template, false)
  allow_merge_commit          = try(each.value.allow_merge_commit, true)
  allow_squash_merge          = try(each.value.allow_squash_merge, true)
  allow_rebase_merge          = try(each.value.allow_rebase_merge, true)
  allow_auto_merge            = try(each.value.allow_auto_merge, false)
  squash_merge_commit_title   = try(each.value.squash_merge_commit_title, "COMMIT_OR_PR_TITLE")
  squash_merge_commit_message = try(each.value.squash_merge_commit_message, "COMMIT_MESSAGES")
  merge_commit_title          = try(each.value.merge_commit_title, "MERGE_MESSAGE")
  merge_commit_message        = try(each.value.merge_commit_message, "PR_TITLE")
  delete_branch_on_merge      = try(each.value.delete_branch_on_merge, true)
  auto_init                   = try(each.value.auto_init, true)
  gitignore_template          = try(each.value.gitignore_template, null)
  license_template            = try(each.value.license_template, null)
  archived                    = try(each.value.archived, false)
  archive_on_destroy          = try(each.value.archive_on_destroy, false)
  pages                       = try(each.value.pages, null)
  security_and_analysis = {
    # advanced_security = {
    #   status = try(each.value.security_and_analysis.advanced_security.status, null)
    # }
    secret_scanning = {
      status = try(each.value.security_and_analysis.secret_scanning.status, "enabled")
    }
    secret_scanning_push_protection = {
      status = try(each.value.security_and_analysis.secret_scanning_push_protection.status, "enabled")
    }
  }
  topics                                  = concat(["terraform-workspace", "terraform", "terraform-managed"], each.value.topics)
  template                                = try(each.value.template, null)
  vulnerability_alerts                    = try(each.value.vulnerability_alerts, true)
  ignore_vulnerability_alerts_during_read = try(each.value.ignore_vulnerability_alerts_during_read, false)
  allow_update_branch                     = try(each.value.allow_update_branch, false)

  branch_protections = [for branch_protection in try(each.value.branch_protections, [
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
    ]) :
    {
      pattern                         = branch_protection.pattern
      enforce_admins                  = try(branch_protection.enforce_admins, true)
      require_signed_commits          = try(branch_protection.require_signed_commits, false)
      required_linear_history         = try(branch_protection.required_linear_history, false)
      require_conversation_resolution = try(branch_protection.require_conversation_resolution, true)
      required_status_checks          = try(branch_protection.required_status_checks, null)
      required_pull_request_reviews = {
        dismiss_stale_reviews           = try(branch_protection.required_pull_request_reviews.dismiss_stale_reviews, true)
        restrict_dismissals             = try(branch_protection.required_pull_request_reviews.restrict_dismissals, null)
        dismissal_restrictions          = try(branch_protection.required_pull_request_reviews.dismissal_restrictions, null)
        pull_request_bypassers          = try(branch_protection.required_pull_request_reviews.pull_request_bypassers, null)
        require_code_owner_reviews      = try(branch_protection.required_pull_request_reviews.require_code_owner_reviews, true)
        required_approving_review_count = try(branch_protection.required_pull_request_reviews.required_approving_review_count, "0")
        require_last_push_approval      = try(branch_protection.required_pull_request_reviews.require_last_push_approval, false)
      }
      push_restrictions    = try(branch_protection.push_restrictions, null)
      force_push_bypassers = try(branch_protection.force_push_bypassers, null)
      allows_deletions     = try(branch_protection.allows_deletions, false)
      allows_force_pushes  = try(branch_protection.allows_force_pushes, false)
      blocks_creations     = try(branch_protection.blocks_creations, false)
      lock_branch          = try(branch_protection.lock_branch, false)
    }
  ]

  # TO BE VALIDATED IF REQUIRED
  actions_secrets = [for secret in try(each.value.actions_secrets, []) :
    {
      secret_name     = secret.secret_name
      plaintext_value = secret.plaintext_value
      # plaintext_value = secret.secret_name == "TF_API_TOKEN" ? try(module.teams[secret.plaintext_value].token, null) : secret.plaintext_value
    }
  ]

  # TO BE VALIDATED IF REQUIRED
  branches = [for branch in try(each.value.branches, []) :
    {
      branch        = branch.branch
      source_branch = try(branch.source_branch, "main")
    }
  ]

}