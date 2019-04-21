variable "role_name" {
  type        = "string"
  description = "The name of the role."
}

variable "username" {
  type        = "string"
  description = "The name of the user."
}

variable "length" {
  type        = "string"
  description = "The length of the external id desired."
  default     = "16"
}

variable "period" {
  type    = "string"
  default = 32400
}

variable "path" {
  type    = "string"
  default = "ci"
}

variable "service" {
  type    = "string"
  default = "GitLab"
}

variable "environment_variable" {
  type        = "map"
  description = "Times"
  default     = {}
}

variable "tags" {
  type        = "map"
  description = "Key-value mapping of tags for the IAM role."
  default     = {}
}

variable "labels" {
  type    = "map"
  default = {}
}
