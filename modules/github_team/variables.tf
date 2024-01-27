variable "name" {
  description = "(Required) The name of the team."
  type        = string
}

variable "description" {
  description = "(Optional) A description of the team."
  type        = string
  default     = null
}

variable "privacy" {
  description = "(Optional) The level of privacy for the team. Must be one of `secret` or `closed`."
  type        = string
  default     = "secret"
  validation {
    condition     = var.privacy != null ? contains(["secret", "closed"], var.privacy) ? true : false : true
    error_message = "Valid values are `secret`, or `closed`."
  }
}

variable "parent_team_id" {
  description = "(Optional) The ID or slug of the parent team, if this is a nested team."
  type        = string
  default     = null
}

variable "ldap_dn" {
  description = "(Optional) The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise Server."
  type        = string
  default     = null
}

variable "create_default_maintainer" {
  description = "(Optional) Adds a default maintainer to the team. Defaults to `false` and adds the creating user to the team when `true`."
  type        = bool
  default     = false
}
