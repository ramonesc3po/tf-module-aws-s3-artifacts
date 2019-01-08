output "name_bucket" {
  value = "${element(concat(aws_s3_bucket.bucket_no_encrypt.*.bucket, aws_s3_bucket.bucket_encrypt.*.bucket), 0)}"
}

output "domain_name_bucket" {
  value = "${element(concat(aws_s3_bucket.bucket_no_encrypt.*.bucket_domain_name, aws_s3_bucket.bucket_encrypt.*.bucket_domain_name), 0)}"
}

output "id_bucket" {
  value = "${element(concat(aws_s3_bucket.bucket_no_encrypt.*.id, aws_s3_bucket.bucket_encrypt.*.id), 0)}"
}

output "arn_bucket" {
  value = "${element(concat(aws_s3_bucket.bucket_no_encrypt.*.arn, aws_s3_bucket.bucket_encrypt.*.arn), 0)}"
}
