resource "google_compute_firewall" "firewall" {
  for_each      = { for rule in var.firewall_rules : rule.name => rule }
  name          = each.value.name
  network       = var.network
  direction     = each.value.direction
  source_ranges = each.value.source_ranges
  target_tags   = lookup(each.value, "target_tags", null)
  priority      = lookup(each.value, "priority", null)

  dynamic "allow" {
    for_each = each.value.allow
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }
}