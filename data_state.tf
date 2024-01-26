# The following block are used to retrieve information from state file.
data "terraform_remote_state" "aws-oidc-terraformcloud" {
  backend = "remote"

  config = {
    organization = local.organization_name
    workspaces = {
      name = "AWS-OIDC-TerraformCloud"
    }
  }
}