# Null Resource Module

This Terraform module creates a null resource with configurable local and remote exec provisioners. This is useful for running scripts, commands, or other operations as part of your Terraform workflow.

## Features

- Optional creation control
- Configurable triggers for resource recreation
- Local exec provisioner with environment variables
- Remote exec provisioner with SSH/WinRM connection
- Flexible command execution timing

## Usage

### Basic Local Exec

```hcl
module "null_resource" {
  source = "./null_resource"

  local_exec_command = "echo 'Hello from Terraform!'"
  triggers = {
    timestamp = timestamp()
  }
}
```

### Local Exec with Environment Variables

```hcl
module "null_resource" {
  source = "./null_resource"

  local_exec_command = "echo $MESSAGE"
  environment_variables = {
    MESSAGE = "Hello from environment!"
  }
  working_dir = "/tmp"
  triggers = {
    version = "1.0.0"
  }
}
```

### Remote Exec

```hcl
module "null_resource" {
  source = "./null_resource"

  remote_exec_commands = [
    "sudo apt-get update",
    "sudo apt-get install -y nginx"
  ]
  
  connection_host     = "10.0.0.100"
  connection_user     = "ubuntu"
  connection_private_key = file("~/.ssh/id_rsa")
  
  triggers = {
    config_version = "2.0"
  }
}
```

### Conditional Creation

```hcl
module "null_resource" {
  source = "./null_resource"

  create = var.enable_script
  
  local_exec_command = "echo 'Script executed'"
  triggers = {
    environment = var.environment
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the null resource | `bool` | `true` | no |
| triggers | A map of arbitrary strings that, when changed, will trigger the recreation of the resource | `map(string)` | `{}` | no |
| local_exec_command | Command to execute locally | `string` | `"echo 'No command specified'"` | no |
| working_dir | Working directory for the local-exec provisioner | `string` | `null` | no |
| environment_variables | Environment variables for the local-exec provisioner | `map(string)` | `{}` | no |
| local_exec_when | When to run the local-exec provisioner | `string` | `"create"` | no |
| remote_exec_commands | List of commands to execute remotely | `list(string)` | `null` | no |
| connection_type | Type of connection for remote-exec provisioner | `string` | `"ssh"` | no |
| connection_host | Host for remote connection | `string` | `null` | no |
| connection_user | User for remote connection | `string` | `null` | no |
| connection_private_key | Private key for SSH connection | `string` | `null` | no |
| connection_password | Password for remote connection | `string` | `null` | no |
| connection_port | Port for remote connection | `number` | `22` | no |
| connection_timeout | Timeout for remote connection | `string` | `"5m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the null resource |
| triggers | The triggers used for the null resource |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |

## Providers

No providers required.

## Version History

- **v1.1.0**: Added version constraints file and command validation
- **v1.0.0**: Initial release with basic null resource functionality

## Notes

- The `local_exec_when` variable accepts either "create" or "destroy" values
- The `connection_type` variable accepts either "ssh" or "winrm" values
- Sensitive variables like `connection_private_key` and `connection_password` are marked as sensitive
- Use triggers to control when the resource should be recreated
- The `create` variable allows for conditional creation of the resource
