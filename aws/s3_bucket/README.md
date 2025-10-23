# AWS S3 Bucket Module

This Terraform module creates an AWS S3 bucket with configurable options for versioning, encryption, public access blocking, and lifecycle rules.

## Features

- Creates an S3 bucket with a specified name
- Optional versioning configuration
- Optional server-side encryption (AES256 or KMS)
- Optional public access blocking
- Optional lifecycle rules for object expiration
- Comprehensive output values

## Usage

```hcl
module "s3_bucket" {
  source = "./aws/s3_bucket"

  bucket_name         = "my-unique-bucket-name"
  versioning_enabled  = true
  encryption_enabled  = true
  block_public_access = true

  tags = {
    Environment = "production"
    Project     = "my-project"
  }

  lifecycle_rules = [
    {
      id                                    = "delete_old_versions"
      status                                = "Enabled"
      expiration_days                       = 30
      noncurrent_version_expiration_days    = 7
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket_name | Name of the S3 bucket | `string` | n/a | yes |
| versioning_enabled | Enable versioning for the S3 bucket | `bool` | `false` | no |
| encryption_enabled | Enable server-side encryption for the S3 bucket | `bool` | `true` | no |
| encryption_algorithm | Server-side encryption algorithm to use | `string` | `"AES256"` | no |
| block_public_access | Block all public access to the S3 bucket | `bool` | `true` | no |
| tags | A map of tags to assign to the S3 bucket | `map(string)` | `{}` | no |
| lifecycle_rules | List of lifecycle rules for the S3 bucket | `list(object)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | The ID of the S3 bucket |
| bucket_arn | The ARN of the S3 bucket |
| bucket_domain_name | The bucket domain name |
| bucket_regional_domain_name | The bucket region-specific domain name |
| bucket_hosted_zone_id | The Route 53 Hosted Zone ID for this bucket's region |
| bucket_region | The AWS region this bucket resides in |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 5.0 |

## Version History

- **v1.1.0**: Added bucket name validation and version constraints file
- **v1.0.0**: Initial release with basic S3 bucket functionality
