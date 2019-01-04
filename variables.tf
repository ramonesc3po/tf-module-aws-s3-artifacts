variable "is_encrypted" {
  default = false
}

variable "bucket_name" {
  description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name."
  type        = "string"
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the bucket."
  type        = "map"
  default     = {}
}

variable "acl" {
  description = "(Optional) The canned ACL to apply. Defaults to private."
  default     = "private"
}

variable "force_destroy" {
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = false
}

variable "versioning_is_enabled" {
  description = "(Optional) A state of versioning (documented below)"
  default     = false
}

variable "logging_target_bucket" {
  description = "(Optional) A settings of bucket logging (documented below)."
  default     = ""
}

variable "lifecycle_rule_is_enabled" {
  description = "(Optional) A configuration of object lifecycle management (documented below)."
  default     = "false"
}

variable "versioning_enabled" {
  description = "(Optional) A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket."
  default     = "false"
}

variable "noncurrent_version_expiration_days" {
  description = "(Optional) Specifies when noncurrent object versions expire."
  default     = "90"
}

variable "noncurrent_version_transition_days" {
  description = "(Optional) Specifies when noncurrent object versions transitions"
  default     = "30"
}

variable "standard_transition_days" {
  description = "Number of days to persist in the standard storage tier before moving to the infrequent access tier"
  default     = "30"
}

variable "glacier_transition_days" {
  description = "Number of days after which to move the data to the glacier storage tier"
  default     = "60"
}

variable "expiration_days" {
  description = "Number of days after which to expunge the objects"
  default     = "90"
}

variable "prefix" {
  description = "(Optional) Key prefix. Used to manage object lifecycle events."
  default     = ""
}

variable "sse_algorithm" {
  description = "The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
  default     = "aws:kms"
}

variable "kms_master_key_id" {
  description = "The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms"
  default     = ""
}

variable "s3_actions" {
  description = "Set actions policy s3"
  type        = "list"

  default = [
    "s3:GetObject",
  ]
}

variable "s3_resources" {
  description = "Set resources policy s3"
  type = "list"
  default = []
}

variable "bucket_tier" {
  description = "(Required) Definie which environment would use this resource, example: production"
}

variable "bucket_organization" {
  description = "(Optional) Define which organization would use this resource"
  default     = ""
}

variable "bucket_region" {
  description = "(Required) Define region"
}
