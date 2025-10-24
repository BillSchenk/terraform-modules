variable "create" {
  description = "Whether to create the null resource"
  type        = bool
  default     = true
}

variable "triggers" {
  description = "A map of arbitrary strings that, when changed, will trigger the recreation of the resource"
  type        = map(string)
  default     = {}
}

variable "local_exec_command" {
  description = "Command to execute locally"
  type        = string
  default     = "echo 'No command specified'"
  validation {
    condition     = var.local_exec_command != null && var.local_exec_command != ""
    error_message = "local_exec_command cannot be null or empty."
  }
}

variable "working_dir" {
  description = "Working directory for the local-exec provisioner"
  type        = string
  default     = null
}

variable "environment_variables" {
  description = "Environment variables for the local-exec provisioner"
  type        = map(string)
  default     = {}
}

variable "local_exec_when" {
  description = "When to run the local-exec provisioner"
  type        = string
  default     = "create"
  validation {
    condition     = contains(["create", "destroy"], var.local_exec_when)
    error_message = "local_exec_when must be either 'create' or 'destroy'."
  }
}

variable "remote_exec_commands" {
  description = "List of commands to execute remotely"
  type        = list(string)
  default     = null
}

variable "connection_type" {
  description = "Type of connection for remote-exec provisioner"
  type        = string
  default     = "ssh"
  validation {
    condition     = contains(["ssh", "winrm"], var.connection_type)
    error_message = "connection_type must be either 'ssh' or 'winrm'."
  }
}

variable "connection_host" {
  description = "Host for remote connection"
  type        = string
  default     = null
}

variable "connection_user" {
  description = "User for remote connection"
  type        = string
  default     = null
}

variable "connection_private_key" {
  description = "Private key for SSH connection"
  type        = string
  default     = null
  sensitive   = true
}

variable "connection_password" {
  description = "Password for remote connection"
  type        = string
  default     = null
  sensitive   = true
}

variable "connection_port" {
  description = "Port for remote connection"
  type        = number
  default     = 22
}

variable "connection_timeout" {
  description = "Timeout for remote connection"
  type        = string
  default     = "5m"
}

variable "module_version" {
  description = "Version of the module to echo"
  type        = string
  default     = "1.0.1"
}
