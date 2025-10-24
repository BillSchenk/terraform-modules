resource "null_resource" "this" {
  count = var.create ? 1 : 0

  triggers = {
    module_version = var.module_version
  }

  provisioner "local-exec" {
    command = "echo 'Module version: ${var.module_version}'"
    when    = "create"
  }
}
