# GitHub repository Terraform module

GitHub team module which manages configuration and life-cycle 
of all your GitHub teams configuration.

## Permissions

To manage the GitHub resources, provide a token from an account or a GitHub App with 
appropriate permissions. It should have:

* Read access to `metadata`
* Read and write access to `administration`, `code`, `members` and `secrets`

## Authentication

The GitHub provider requires a GitHub token or GitHub App installation in order to manage resources.

There are several ways to provide the required token:

- Set the `token` argument in the provider configuration. You can set the `token` argument in the provider configuration. Use an
input variable for the token.
- Set the `GITHUB_TOKEN` environment variable. The provider can read the `GITHUB_TOKEN` environment variable and the token stored there
to authenticate.

There are several ways to provide the required GitHub App installation:

- Set the `app_auth` argument in the provider configuration. You can set the app_auth argument with the id, installation_id and pem_file
in the provider configuration. The owner parameter is also required in this situation.
- Set the `GITHUB_APP_ID`, `GITHUB_APP_INSTALLATION_ID` and `GITHUB_APP_PEM_FILE` environment variables. The provider can read the GITHUB_APP_ID,
GITHUB_APP_INSTALLATION_ID and GITHUB_APP_PEM_FILE environment variables to authenticate.

> Because strings with new lines is not support:</br>
> use "\\\n" within the `pem_file` argument to replace new line</br>
> use "\n" within the `GITHUB_APP_PEM_FILE` environment variables to replace new line</br>

## Features

- Create and manage team within your GitHub organization or personal account.

## Usage example
```hcl
module "team" {
  source = "./modules/github_team"

  name               = "Team Name"
  destination_type   = "This is a description for the GitHub team."
}
```

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->