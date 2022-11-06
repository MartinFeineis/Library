provider "google-beta" {
  credentials = file("personalKeys.json")
  region      = "us-east4"
  zone        = "us-east4-c"
  project  = var.my_project
}

resource "google_api_gateway_api" "api_mfe" {
  provider = google-beta
  api_id   = "apimfe"
}

#resource "google_project_service" "gcp_services" {
#  for_each = toset(var.gcp_enabled_services)
#  service = each.key
#}

resource "google_api_gateway_api_config" "api_cfg" {
  provider      = google-beta
  api           = google_api_gateway_api.api_mfe.api_id
  api_config_id = "cfg"

  openapi_documents {
    document {
      path     = "spec.yaml"
      contents = filebase64("source/openapi.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_gateway" "api_gw" {
  provider   = google-beta
  api_config = google_api_gateway_api_config.api_cfg.id
  gateway_id = "api-gw"
}

output "apigateway_address" {
  value = google_api_gateway_gateway.api_gw.default_hostname
}
