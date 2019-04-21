# AWS IAM External Role

Terraform module for a continuous integration user-role pairing.

These types of resources are supported:

- [IAM Role](https://www.terraform.io/docs/providers/aws/r/iam_role.html)

## Usage

```hcl
module "cicd_setup" {
  source = "git::https://gitlab.com/infraprints/modules/aws/iam-ci-role"

  username  = "infraprints-iam-ci-role-basic"
  role_name = "infraprints-iam-ci-role-basic"

  environment_variable = {
    s3_bucket   = "infraprints-bucket-example"
    hello_world = "hello world"
  }
}

```

## Examples

- [Basic Example](examples/basic)

## Notes

- Environment variables are prefixed with `ENV_` to prevent them

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| environment\_variable | Times | map | `<map>` | no |
| labels |  | map | `<map>` | no |
| length | The length of the external id desired. | string | `"16"` | no |
| path |  | string | `"ci"` | no |
| period |  | string | `"32400"` | no |
| role\_name | The name of the role. | string | n/a | yes |
| service |  | string | `"GitLab"` | no |
| tags | Key-value mapping of tags for the IAM role. | map | `<map>` | no |
| username | The name of the user. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name (ARN) specifying the role. |
| create\_date | The Amazon Resource Name (ARN) specifying the role. |
| unique\_id | The Amazon Resource Name (ARN) specifying the role. |

