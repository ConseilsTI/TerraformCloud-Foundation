resource "github_actions_secret" "this" {
  for_each        = nonsensitive({ for secret in local.git_actions_secrets : secret.key => secret })
  repository      = module.git_repository[each.value.repository].repository.name
  secret_name     = each.value.secret_name
  plaintext_value = each.value.plaintext_value
}