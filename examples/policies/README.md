# Policies Usage

This shows an example of Terraform code to deploy an IAM User and role pair for use in continuous integration.

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which can cost money. Run `terraform destroy` when you don't need these resources.

## Notes

- ExternalID