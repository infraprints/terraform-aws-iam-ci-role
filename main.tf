locals {
  global = {
    External       = true
    Credentials    = true
    RotationPeriod = "${var.period}"
  }

  labels = {
    AccessKeyLabel = "${lookup(var.labels, "access_key", "AWS_ACCESS_KEY_ID")}"
    SecretKeyLabel = "${lookup(var.labels, "secret_key", "AWS_SECRET_ACCESS_KEY")}"
    TokenLabel     = "${lookup(var.labels, "token", "AWS_SESSION_TOKEN")}"
  }

  adjusted_with_prefix = "${formatlist("ENV_%s", keys(var.environment_variable))}"
  adjusted_env_vars    = "${zipmap(local.adjusted_with_prefix, values(var.environment_variable))}"
}

resource "aws_iam_role" "external" {
  name                  = "${var.role_name}"
  path                  = "/${lower(var.path)}/${lower(var.service)}/"
  assume_role_policy    = "${data.aws_iam_policy_document.external_role.json}"
  description           = "User-linked role accessible by ${var.username} for |SAMPLE|"
  max_session_duration  = 43200
  force_detach_policies = true

  tags = "${merge(local.global, var.tags, local.labels)}"
}

resource "aws_iam_user" "external" {
  name = "${var.username}"
  path = "/${lower(var.path)}/${lower(var.service)}/"
  tags = "${merge(local.global, local.adjusted_env_vars, var.tags, local.labels)}"
}

resource "random_string" "external_id" {
  length  = "${var.length}"
  special = false
}

data "aws_iam_policy_document" "external_role" {
  statement {
    sid     = "AllowUserAssume"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_iam_user.external.arn}"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["${random_string.external_id.result}"]
    }
  }
}

resource "aws_iam_user_policy" "external" {
  name   = "AssumeRole"
  user   = "${aws_iam_user.external.name}"
  policy = "${data.aws_iam_policy_document.external_user.json}"
}

data "aws_iam_policy_document" "external_user" {
  statement {
    sid       = "AllowAssumeOfRole"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["${aws_iam_role.external.arn}"]
  }
}
