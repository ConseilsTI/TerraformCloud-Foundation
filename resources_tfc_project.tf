# The following resource block is used to create project resources.

resource "tfe_project" "this" {
  name         = local.tfc_project
  organization = data.tfe_organization.this.name
}

moved {
  from = tfe_project.project["Terraform Cloud"]
  to   = tfe_project.this
}