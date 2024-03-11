# The following resource block is used to create project resources.

resource "tfe_project" "project" {
  for_each = local.projects

  name         = each.key
  organization = data.tfe_organization.this.name
}
