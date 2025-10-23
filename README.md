# Terraform Modules

This repository contains reusable Terraform modules for common infrastructure patterns.

## Available Modules

### AWS Modules

#### [S3 Bucket](./aws/s3_bucket/)
A comprehensive S3 bucket module with configurable options for versioning, encryption, public access blocking, and lifecycle rules.

**Features:**
- Configurable versioning
- Server-side encryption (AES256 or KMS)
- Public access blocking
- Lifecycle rules for object management
- Comprehensive outputs

### Utility Modules

#### [Null Resource](./null_resource/)
A flexible null resource module with local and remote exec provisioners for running scripts and commands as part of your Terraform workflow.

**Features:**
- Local exec provisioner with environment variables
- Remote exec provisioner with SSH/WinRM support
- Configurable triggers for resource recreation
- Conditional creation control

## Usage

Each module includes detailed documentation in its respective directory. Here's a quick example of how to use the modules:

```hcl
# Example: Using the S3 bucket module
module "my_bucket" {
  source = "./aws/s3_bucket"

  bucket_name         = "my-unique-bucket-name"
  versioning_enabled  = true
  encryption_enabled  = true
  block_public_access = true

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}

# Example: Using the null resource module
module "my_script" {
  source = "./null_resource"

  local_exec_command = "echo 'Hello from Terraform!'"
  triggers = {
    timestamp = timestamp()
  }
}
```

## Requirements

- Terraform >= 1.0
- AWS Provider >= 5.0 (for AWS modules)

## Contributing

When adding new modules, please ensure:

1. Include comprehensive documentation in README.md
2. Provide example usage
3. Include all necessary variable validations
4. Document all inputs and outputs
5. Follow consistent naming conventions
6. Include version requirements

## License

This project is licensed under the MIT License.
