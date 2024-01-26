output "id" {
  description = "The ID of the notification configuration."
  value       = tfe_notification_configuration.this.id
}

output "notification_configuration" {
  description = "Terraform Cloud notification configuration resource."
  value       = tfe_notification_configuration.this
}