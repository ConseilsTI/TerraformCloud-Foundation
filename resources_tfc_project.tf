# The following resource block is used to create project resources.

resource "tfe_project" "this" {
  name         = local.tfc_project
  organization = data.tfe_organization.this.name
}

# moved {
#   from = 
#   to   = 
# }