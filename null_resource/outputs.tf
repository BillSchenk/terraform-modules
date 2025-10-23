output "id" {
  description = "The ID of the null resource"
  value       = var.create ? null_resource.this[0].id : null
}

output "triggers" {
  description = "The triggers used for the null resource"
  value       = var.triggers
}
