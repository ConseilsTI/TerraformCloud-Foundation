# The following resource block is used to create GitHub team resources.

module "github_teams" {
  source = "./modules/github_team"

  for_each = nonsensitive({ for team in local.git_teams : team.name => team })

  name                      = each.value.name
  description               = try(each.value.description, null)
  privacy                   = try(each.value.privacy, "closed")
  parent_team_id            = try(each.value.parent_team_id, null)
  ldap_dn                   = try(each.value.ldap_dn, null)
  create_default_maintainer = try(each.value.create_default_maintainer, false)
  repository                = try(each.value.repository, null)
  permission                = try(each.value.permission, null)
}