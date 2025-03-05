resource "google_compute_global_address" "lb-external-addr" {
  name = "xlb-static"
  ip_version = "IPV4"
}

resource "google_compute_health_check" "default" {
  name = "http-basic-check"
  check_interval_sec = 5
  healthy_threshold = 2

  http_health_check {
    port = 80
    port_specification = "USE_FIXED_PORT"
    proxy_header = "NONE"
    request_path = "/"
  }

  timeout_sec = 5
  unhealthy_threshold = 2
}

resource "google_compute_backend_service" "default" {
  name = "xlb-backend-service"
  connection_draining_timeout_sec = 0
  health_checks = [google_compute_health_check.default.id]
  load_balancing_scheme = "EXTERNAL"
  port_name = "http"
  protocol = "HTTP"
  session_affinity = "NONE"
  timeout_sec = 30

  backend {
    group = var.instance_group
    balancing_mode = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_url_map" "default" {
  name = "xlb-url-map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_http_proxy" "default" {
  name = "xlb-http-proxy"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_global_forwarding_rule" "default" {
  name = "xlb-forwarding-rule"
  ip_protocol = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range = "80"
  target = google_compute_target_http_proxy.default.id
  ip_address = google_compute_global_address.lb-external-addr.id

}