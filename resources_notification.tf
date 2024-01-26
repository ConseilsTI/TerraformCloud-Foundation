# The following code block is used to create workspace resources in project.

module "notifications" {
  source = "./modules/tfe_notification"

  for_each = nonsensitive({ for notification in local.workspace_notifications : "${notification.workspace} ${notification.name}" => notification })

  name             = each.value.name
  destination_type = each.value.destination_type
  workspace_id     = module.workspaces[each.value.workspace].id
  emails           = try(each.value.emails, null)
  enabled          = try(each.value.enabled, true)
  token            = try(each.value.token, null)
  triggers         = try(each.value.triggers, null)
  url              = try(each.value.url, null)
}