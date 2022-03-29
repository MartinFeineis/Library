provider "google" {
  credentials = file("personalKeys.json")
  region      = "us-east4"
  zone        = "us-east4-c"
  project  = var.my_project
}

resource "google_storage_bucket" "bucket" {
  name     = "mfe-func-pot-uiop"
  location = "US"
}

data "archive_file" "gozipped" {
  type        = "zip"
  source_file = "${path.module}/source/hello_http.go"
  output_path = "${path.module}/source/hello_http.zip"
}

resource "google_storage_bucket_object" "archive" {
  name   = "hellohttp.go"
  bucket = google_storage_bucket.bucket.name
  source = "./source/hello_http.zip"
}

resource "google_cloudfunctions_function" "function" {
  name        = "function-test"
  description = "My function"
  runtime     = "go116"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "HelloHTTP"
  ingress_settings      = "ALLOW_ALL"
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
  #depends_on = [ google_cloudfunctions_function.function, google_project_service.gcp_services] 
}

#module "project-services" {
#  source  = "terraform-google-modules/project-factory/google//modules/project_services"
#  version = "10.1.1"
#  project_id = var.my_project
#  activate_apis = var.gcp_enabled_services
#}
