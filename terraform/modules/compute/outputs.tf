output "image_id" {
  value = google_compute_image.custom-img.id
}

output "image_link" {
  value = google_compute_image.custom-img.self_link
}