resource "github_team" "this" {
  name                      = var.name
  description               = var.description
  privacy                   = var.privacy
  parent_team_id            = var.parent_team_id
  ldap_dn                   = var.ldap_dn
  create_default_maintainer = var.create_default_maintainer
}

resource "github_team_repository" "this" {
  count      = var.repository != null ? 1 : 0
  team_id    = github_team.this.id
  repository = var.repository
  permission = var.permission
}