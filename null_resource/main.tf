resource "null_resource" "this" {
  count = var.create ? 1 : 0

  triggers = var.triggers

  provisioner "local-exec" {
    command     = var.local_exec_command
    working_dir = var.working_dir
    environment = var.environment_variables
    when        = var.local_exec_when
  }

  dynamic "provisioner" {
    for_each = var.remote_exec_commands != null ? [1] : []
    content {
      type = "remote-exec"

      connection {
        type        = var.connection_type
        host        = var.connection_host
        user        = var.connection_user
        private_key = var.connection_private_key
        password    = var.connection_password
        port        = var.connection_port
        timeout     = var.connection_timeout
      }

      inline = var.remote_exec_commands
    }
  }
}
