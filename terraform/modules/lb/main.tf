resource "google_compute_global_address" "lb-external-addr" {
  name = var.static-name
  ip_version = var.ip-version
}

resource "google_compute_health_check" "default" {
  name = var.hc-name
  check_interval_sec = var.check-interval-sec
  healthy_threshold = var.healthy-threshold

  http_health_check {
    port = var.http_health_check.port
    port_specification = var.http_health_check.port_specification
    proxy_header = var.http_health_check.proxy_header
    request_path = var.http_health_check.request_path
  }

  timeout_sec = var.timeout_sec
  unhealthy_threshold = var.unhealthy_threshold
}

resource "google_compute_backend_service" "default" {
  name = var.backend-service-name
  connection_draining_timeout_sec = var.connection-draining-timeout-sec
  health_checks = [google_compute_health_check.default.id]
  load_balancing_scheme = var.load-balancing-scheme
  port_name = var.backend-port-name
  protocol = var.protocol

  backend {
    group = var.instance_group
    balancing_mode = var.balancing-mode
  }
}

resource "google_compute_url_map" "default" {
  name = var.url-map-name
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_http_proxy" "default" {
  name = var.proxy-name
  url_map = google_compute_url_map.default.id
}

resource "google_compute_global_forwarding_rule" "default" {
  name = var.forwarding-rule-name
  ip_protocol = var.ip-protocol
  load_balancing_scheme = var.load-balancing-scheme
  port_range = var.port-range
  target = google_compute_target_http_proxy.default.id
  ip_address = google_compute_global_address.lb-external-addr.id

}