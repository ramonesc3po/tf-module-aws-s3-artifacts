module "artifacts" {
  source = "../"

  is_encrypted = "true"

  bucket_name         = "artifacts"
  bucket_region       = "us-east-1"
  bucket_tier         = "production"
  bucket_organization = "zigzaga"

  versioning_is_enabled = "true"

  lifecycle_rule_is_enabled = "true"

  logging_target_bucket = "${}"

  kms_master_key_id = ""

  s3_actions = [
    "s3:GetObject",
    "s3:ListObject",
  ]

  s3_resources = ["*"]
}
