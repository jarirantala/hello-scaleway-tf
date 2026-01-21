resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "scaleway_object_bucket" "frontend" {
  name   = "hello-world-frontend-${random_id.bucket_suffix.hex}"
  region = var.region
}

resource "scaleway_object_bucket_acl" "frontend_acl" {
  bucket = scaleway_object_bucket.frontend.name
  acl    = "public-read"
  region = var.region
}

resource "scaleway_object_bucket_website_configuration" "frontend_website" {
  bucket = scaleway_object_bucket.frontend.name
  region = var.region
  index_document {
    suffix = "index.html"
  }
}

resource "scaleway_object" "index" {
  bucket = scaleway_object_bucket.frontend.name
  key    = "index.html"
  region = var.region
  content = templatefile("${path.module}/src/frontend/index.html", {
    api_url = "https://${scaleway_function.hello.domain_name}"
  })
  content_type = "text/html"
  visibility   = "public-read"
}