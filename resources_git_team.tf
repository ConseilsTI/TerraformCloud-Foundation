# The following resource block is used to create GitHub team resources.

module "github_teams" {

  source = "./modules/git_team"

  for_each = nonsensitive({ for team in local.git_teams : team.name => team })

  name                      = each.value.name
  create_default_maintainer = try(each.value.create_default_maintainer, false)
  description               = try(each.value.description, null)
  ldap_dn                   = try(each.value.ldap_dn, null)
  parent_team_id            = try(each.value.parent_team_id, null)
  permission                = try(each.value.permission, null)
  privacy                   = try(each.value.privacy, "closed")
  repository                = try(each.value.repository, null)
  
}