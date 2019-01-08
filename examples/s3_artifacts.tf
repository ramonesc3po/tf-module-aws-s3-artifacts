module "artifacts" {
  source = "../"
  bucket_name         = "artifacts"
  bucket_region       = "us-east-1"
  bucket_tier         = "production"
  bucket_organization = "zigzaga"

  versioning_is_enabled = "true"

  logging_target_bucket = ""

  lifecycle_rule_is_enabled = "true"

  s3_actions = [
    "s3:GetObject",
    "s3:ListBucket",
    "s3:Delete*"
  ]

  s3_resources = [
    "arn:aws:s3:::zigzaga-artifacts-us-east-1-production/terraform"
  ]
}

output "name_bucket_artifacts" {
  value = "${module.artifacts.name_bucket}"
}

output "domain_name_bucket_artifacts" {
  value = "${module.artifacts.domain_name_bucket}"
}

output "arn_bucket_artifacts" {
  value = "${module.artifacts.arn_bucket}"
}

output "id_bucket_artifacts" {
  value = "${module.artifacts.id_bucket}"
}
