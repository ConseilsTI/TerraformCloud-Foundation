# resource "github_actions_secret" "this" {
#   for_each        = { for secret in var.actions_secrets : secret.secret_name => secret }
#   repository      = github_repository.this.name
#   secret_name     = each.value.secret_name
#   plaintext_value = each.value.plaintext_value
# }