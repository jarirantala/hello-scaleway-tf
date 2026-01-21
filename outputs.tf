output "function_endpoint" {
  value = "https://${scaleway_function.hello.domain_name}"
}

output "website_url" {
  value = "http://${scaleway_object_bucket.frontend.name}.s3-website.${var.region}.scw.cloud"
}