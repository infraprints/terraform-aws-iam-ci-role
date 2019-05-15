module "example" {
  source = "../../"

  username  = "ci-user-policies-basic"
  role_name = "ci-role-policies-basic"

  environment_variable = {
    s3_bucket   = "infraprints-bucket-example"
    hello_world = "hello world"
  }

  policies = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
  ]
}
