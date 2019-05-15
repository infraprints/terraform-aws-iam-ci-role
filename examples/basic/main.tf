module "example" {
  source = "../../"

  username  = "ci-user-basic"
  role_name = "ci-role-basic"

  environment_variable = {
    s3_bucket   = "infraprints-bucket-example"
    hello_world = "hello world"
  }
}
