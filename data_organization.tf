# The following block is use to get information about an organization.
data "tfe_organization" "this" {
  name = local.tfc_organization_name
}