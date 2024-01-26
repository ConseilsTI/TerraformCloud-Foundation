variable "name" {
  description = "(Optional) Name of the notification configuration."
  type        = string
  default     = null
}

variable "destination_type" {
  description = "(Optional) The type of notification configuration payload to send. Valid values are `generic`, `email`, `slack`, or `microsoft-teams`."
  type        = string
  default     = null

  validation {
    condition     = var.destination_type != null ? contains(["generic", "email", "slack", "microsoft-teams"], var.destination_type) ? true : false : true
    error_message = "Valid values are `generic`, `email`, `email`, or `microsoft-teams`."
  }
}

variable "workspace_id" {
  description = "(Required) The id of the workspace that owns the notification configuration."
  type        = string
  default     = null
}

variable "emails" {
  description = "(Optional) Email of the organization's members. This value must not be provided if destination_type is generic, microsoft-teams, or slack."
  type        = list(string)
  default     = null

  validation {
    condition     = var.emails != null ? can([for email in var.emails : regex("^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,})$", email)]) ? true : false : true
    error_message = "Each email must be in a valid address format (e.g., 'user@company.com')."
  }
}

variable "enabled" {
  description = "(Optional) Whether the notification configuration should be enabled or not. Disabled configurations will not send any notifications."
  type        = bool
  default     = true
}

variable "token" {
  description = "(Optional) A write-only secure token for the notification configuration, which can be used by the receiving server to verify request authenticity when configured for notification configurations with a destination type of generic. This value must not be provided if destination_type is email, microsoft-teams, or slack."
  type        = string
  default     = null
}

variable "triggers" {
  description = "(Optional) The array of triggers for which this notification configuration will send notifications. Valid values are `run:created`, `run:planning`, `run:needs_attention`, `run:applying`, `run:completed`, `run:errored`, `assessment:check_failure`, `assessment:drifted`, or `assessment:failed`. If omitted, no notification triggers are configured."
  type        = list(string)
  default     = null

  validation {
    condition     = length([for trigger in var.triggers : trigger if contains(["run:created", "run:planning", "run:needs_attention", "run:applying", "run:completed", "run:errored", "assessment:check_failure", "assessment:drifted", "assessment:failed"], trigger)]) == length(var.triggers)
    error_message = "Valid values are `run:created`, `run:planning`, `run:needs_attention`, `run:applying`, `run:completed`, `run:errored`, `assessment:check_failure`, `assessment:drifted`, or `assessment:failed`"
  }
}

variable "url" {
  description = "(Required if destination_type is `generic`, `microsoft-teams`, or `slack`) The HTTP or HTTPS URL of the notification configuration where notification requests will be made. This value must not be provided if destination_type is email."
  type        = string
  default     = null
}