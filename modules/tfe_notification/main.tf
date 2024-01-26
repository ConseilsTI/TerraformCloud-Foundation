resource "tfe_notification_configuration" "this" {
  name             = var.name
  destination_type = var.destination_type
  workspace_id     = var.workspace_id
  email_user_ids   = var.emails
  enabled          = var.enabled
  token            = var.token
  triggers         = var.triggers
  url              = var.url

  lifecycle {
    precondition {
      condition     = var.emails != null ? var.destination_type == "email" ? true : false : true
      error_message = "`email` value must not be provided if destination_type is `generic`, `microsoft-teams`, or `slack`."
    }
    precondition {
      condition     = var.token != null ? var.destination_type == "generic" ? true : false : true
      error_message = "`token` value must not be provided if destination_type is `email`, `microsoft-teams`, or `slack`."
    }
  }

}