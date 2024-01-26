# The following code blode is used to create agent pools resources.

module "agent" {
  source            = "./modules/tfe_agent"
  for_each          = toset(local.agent_pools)
  name              = each.key
  organization      = data.tfe_organization.this.name
  token_description = ["Token"]
}