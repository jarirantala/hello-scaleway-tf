resource "scaleway_function_namespace" "main" {
  name        = "hello-world-ns"
  description = "Namespace for Hello World function"
  region      = var.region
}

data "archive_file" "backend_zip" {
  type        = "zip"
  source_dir  = "${path.module}/src/backend"
  output_path = "${path.module}/backend.zip"
}

resource "scaleway_function" "hello" {
  namespace_id = scaleway_function_namespace.main.id
  name         = "hello"
  runtime      = "python310"
  handler      = "handler.handle"
  privacy      = "public"
  zip_file     = data.archive_file.backend_zip.output_path
  zip_hash     = data.archive_file.backend_zip.output_base64sha256
  deploy       = true
}