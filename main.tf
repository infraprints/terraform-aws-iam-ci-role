locals {
  global = {
    External       = true
    Credentials    = true
    RotationPeriod = var.period
  }

  labels = {
    AccessKeyLabel = lookup(var.labels, "access_key", "AWS_ACCESS_KEY_ID")
    SecretKeyLabel = lookup(var.labels, "secret_key", "AWS_SECRET_ACCESS_KEY")
    TokenLabel     = lookup(var.labels, "token", "AWS_SESSION_TOKEN")
  }

  adjusted_with_prefix = formatlist("ENV_%s", keys(var.environment_variable))
  adjusted_env_vars    = zipmap(local.adjusted_with_prefix, values(var.environment_variable))
}

resource "aws_iam_role" "external" {
  name                  = var.role_name
  path                  = var.path
  assume_role_policy    = data.aws_iam_policy_document.role.json
  description           = "User-linked role accessible by ${var.username} for deploying resources"
  max_session_duration  = var.max_session_duration
  force_detach_policies = true

  tags = merge(local.global, var.tags, local.labels)
}

resource "aws_iam_role_policy_attachment" "policies" {
  count      = length(var.policies)
  role       = aws_iam_role.external.id
  policy_arn = element(var.policies, count.index)
}

resource "aws_iam_user" "external" {
  name = var.username
  path = var.path
  tags = merge(
    local.global,
    local.adjusted_env_vars,
    var.tags,
    local.labels,
  )
}

resource "random_string" "external_id" {
  length  = var.length
  special = false
}

data "aws_iam_policy_document" "role" {
  statement {
    sid     = "AllowUserAssume"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.external.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [random_string.external_id.result]
    }
  }
}

resource "aws_iam_user_policy" "external" {
  name   = "AssumeRole"
  user   = aws_iam_user.external.name
  policy = data.aws_iam_policy_document.user.json
}

data "aws_iam_policy_document" "user" {
  statement {
    sid       = "AllowAssumeOfRole"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.external.arn]
  }
}

