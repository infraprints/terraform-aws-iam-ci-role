module "cicd_setup" {
  source = "../../"

  username  = "infraprints-iam-ci-role-basic"
  role_name = "infraprints-iam-ci-role-basic"

  environment_variable = {
    s3_bucket   = "infraprints-bucket-example"
    hello_world = "hello world"
  }
}
