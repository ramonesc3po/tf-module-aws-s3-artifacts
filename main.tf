locals {
  common_tags = {
    Tier         = "${var.bucket_tier}"
    Organization = "${var.bucket_organization}"
    Terraform    = "true"
  }

  bucket_artifcats_name = "${var.bucket_organization}-${var.bucket_name}-${var.bucket_region}-${var.bucket_tier}"

  default_resources = [
    "arn:aws:s3:::${local.bucket_artifcats_name}/*",
    "arn:aws:s3:::${local.bucket_artifcats_name}",
  ]
}

data "aws_iam_policy_document" "bucket" {
  statement {
    sid    = "PermissaoEC2ParaBucketArtifacts${var.bucket_tier}"
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com",
      ]
    }

    actions = [
      "${var.s3_actions}",
    ]

    resources = [
      "${concat(var.s3_resources, local.default_resources, list(""))}",
    ]
  }
}

resource "aws_s3_bucket" "bucket_no_encrypt" {
  count = "${var.is_encrypted ? 0 : 1}"

  bucket        = "${var.bucket_organization}-${var.bucket_name}-${var.bucket_region}-${var.bucket_tier}"
  region        = "${var.bucket_region}"
  policy        = "${data.aws_iam_policy_document.bucket.json}"
  acl           = "${var.acl}"
  force_destroy = "${var.force_destroy}"

  lifecycle_rule {
    enabled = "${var.lifecycle_rule_is_enabled}"
    prefix  = "${var.prefix}"

    noncurrent_version_expiration {
      days = "${var.noncurrent_version_expiration_days}"
    }

    noncurrent_version_transition {
      days          = "${var.noncurrent_version_transition_days}"
      storage_class = "GLACIER"
    }

    transition {
      days          = "${var.standard_transition_days}"
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = "${var.expiration_days}"
    }
  }

  logging {
    target_bucket = "${var.logging_target_bucket}"
  }

  versioning {
    enabled = "${var.versioning_is_enabled}"
  }

  tags = "${merge(local.common_tags, var.tags, map("Name", local.bucket_artifcats_name))}"
}

resource "aws_s3_bucket" "bucket_encrypt" {
  count = "${var.is_encrypted ? 1 : 0}"

  bucket        = "${var.bucket_organization}-${var.bucket_name}-${var.bucket_region}-${var.bucket_tier}"
  region        = "${var.bucket_region}"
  policy        = "${data.aws_iam_policy_document.bucket.json}"
  acl           = "${var.acl}"
  force_destroy = "${var.force_destroy}"

  lifecycle_rule {
    enabled = "${var.lifecycle_rule_is_enabled}"
    prefix  = "${var.prefix}"

    noncurrent_version_expiration {
      days = "${var.noncurrent_version_expiration_days}"
    }

    noncurrent_version_transition {
      days          = "${var.noncurrent_version_transition_days}"
      storage_class = "GLACIER"
    }

    transition {
      days          = "${var.standard_transition_days}"
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = "${var.expiration_days}"
    }
  }

  logging {
    target_bucket = "${var.logging_target_bucket}"
  }

  versioning {
    enabled = "${var.versioning_is_enabled}"
  }

  server_side_encryption_configuration {
    "rule" {
      "apply_server_side_encryption_by_default" {
        sse_algorithm     = "${var.sse_algorithm}"
        kms_master_key_id = "${var.kms_master_key_id}"
      }
    }
  }

  tags = "${merge(local.common_tags, var.tags, map("Name", local.bucket_artifcats_name))}"
}
