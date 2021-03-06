//role
variable "role_name" {
  type        = string
  description = "The name of the role."
}

//user
variable "username" {
  type        = string
  description = "The name of the user."
}

variable "length" {
  type        = string
  description = "The length of the external id desired."
  default     = "16"
}

variable "period" {
  type    = string
  default = 32400
}

variable "max_session_duration" {
  type    = string
  default = 32400
}

variable "path" {
  type    = string
  default = "/ci/"
}

variable "environment_variable" {
  type        = map(string)
  description = "Times"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Key-value mapping of tags for the IAM resources."
  default     = {}
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "policies" {
  type        = list(string)
  description = "The default policies applied to the IAM Role."
  default     = []
}

