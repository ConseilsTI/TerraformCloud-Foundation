# The following code blode is used to create agent pools resources.

module "tfe_agent" {
  source = "./modules/tfe_agent"

  for_each = nonsensitive(toset(local.tfc_agent_pools))

  name              = each.key
  organization      = data.tfe_organization.this.name
  token_description = ["Token"]
}