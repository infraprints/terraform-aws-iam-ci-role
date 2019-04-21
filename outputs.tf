output "arn" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = "${aws_iam_role.external.arn}"
}

output "create_date" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = "${aws_iam_role.external.create_date}"
}

output "unique_id" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = "${aws_iam_role.external.unique_id}"
}
