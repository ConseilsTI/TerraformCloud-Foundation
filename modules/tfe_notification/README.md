# TFC notification Terraform module

Terraform notification module which manages configuration and life-cycle 
of all your Terraform Cloud notification configuration.

## Permissions

To manage the notification resources, provide a user token from an account with 
appropriate permissions. This user should belong to the `admin` team of the workspace. 
Alternatively, you can use a token from a team with `admin` permission instead of a
user token.

## Authentication

The Terraform Cloud provider requires a Terraform Cloud/Enterprise API token in 
order to manage resources.

There are several ways to provide the required token:

- Set the `token` argument in the provider configuration. You can set the token argument in the provider configuration. Use an
input variable for the token.
- Set the `TFE_TOKEN` environment variable. The provider can read the TFE_TOKEN environment variable and the token stored there
to authenticate.

## Features

- Create and manage notification for a workspace.

## Usage example
```hcl
module "team" {
  source = "./modules/tfe_notification"

  name             = "Notification Name"
  destination_type = "microsoft-teams"
  triggers         = ["run:created", "run:planning", "run:errored"]
  url              = "https://example.com"
  workspace_id     = "Workspace_Id"

}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) (0.48.0)

## Providers

The following providers are used by this module:

- <a name="provider_tfe"></a> [tfe](#provider\_tfe) (0.48.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [tfe_notification_configuration.this](https://registry.terraform.io/providers/hashicorp/tfe/0.48.0/docs/resources/notification_configuration) (resource)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_destination_type"></a> [destination\_type](#input\_destination\_type)

Description: (Optional) The type of notification configuration payload to send. Valid values are `generic`, `email`, `slack`, or `microsoft-teams`.

Type: `string`

Default: `null`

### <a name="input_emails"></a> [emails](#input\_emails)

Description: (Optional) Email of the organization's members. This value must not be provided if destination\_type is generic, microsoft-teams, or slack.

Type: `list(string)`

Default: `null`

### <a name="input_enabled"></a> [enabled](#input\_enabled)

Description: (Optional) Whether the notification configuration should be enabled or not. Disabled configurations will not send any notifications.

Type: `bool`

Default: `true`

### <a name="input_name"></a> [name](#input\_name)

Description: (Optional) Name of the notification configuration.

Type: `string`

Default: `null`

### <a name="input_token"></a> [token](#input\_token)

Description: (Optional) A write-only secure token for the notification configuration, which can be used by the receiving server to verify request authenticity when configured for notification configurations with a destination type of generic. This value must not be provided if destination\_type is email, microsoft-teams, or slack.

Type: `string`

Default: `null`

### <a name="input_triggers"></a> [triggers](#input\_triggers)

Description: (Optional) The array of triggers for which this notification configuration will send notifications. Valid values are `run:created`, `run:planning`, `run:needs_attention`, `run:applying`, `run:completed`, `run:errored`, `assessment:check_failure`, `assessment:drifted`, or `assessment:failed`. If omitted, no notification triggers are configured.

Type: `list(string)`

Default: `null`

### <a name="input_url"></a> [url](#input\_url)

Description: (Required if destination\_type is `generic`, `microsoft-teams`, or `slack`) The HTTP or HTTPS URL of the notification configuration where notification requests will be made. This value must not be provided if destination\_type is email.

Type: `string`

Default: `null`

### <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id)

Description: (Required) The id of the workspace that owns the notification configuration.

Type: `string`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_id"></a> [id](#output\_id)

Description: The ID of the notification configuration.

### <a name="output_notification_configuration"></a> [notification\_configuration](#output\_notification\_configuration)

Description: Terraform Cloud notification configuration resource.
<!-- END_TF_DOCS -->