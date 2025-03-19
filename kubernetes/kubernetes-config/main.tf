resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace_name
  }
}

resource "kubernetes_deployment" "deployment" {
  metadata {
    name = var.deployment_name
    labels = {
      app = var.deployment_label
    }
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = var.pod_label
      }
    }
    template {
      metadata {
        labels = {
          app = var.pod_label
        }
      }

      spec {
        container {
          image = var.container_image
          image_pull_policy = "Always"
          name = var.container_name
      
          resources {
            limits = {
              memory = "512M"
              cpu = "1"
            }
            requests = {
              memory = "256M"
              cpu = "50m"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "service" {
  
  metadata {
    generate_name = "misikori-k8s-service"
    # name = var.service_name
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }

  spec {
    selector = {
      app = kubernetes_deployment.deployment.metadata.0.labels.app
    }

    session_affinity = "ClientIP"
    port {
      port = var.service_port
      target_port = var.service_target_port
    }

    type = var.service_type
  }
}