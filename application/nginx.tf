resource "kubernetes_deployment_v1" "example" {
  metadata {
    name = "nginx-deployment"
    labels = {
      app = "nginx"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "nginx"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          port {
            container_port = 80
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "nginx" {
  metadata {
    name = "nginx"
    labels = {
      app = "nginx"
    }
    namespace = "default"
    annotations = {
      "kubernetes.io/elb.class" = "performance"
      "kubernetes.io/elb.autocreate" = jsonencode({
        "type"                 = "public",
        "bandwidth_name"       = "cce-bandwidth-1626694478577",
        "bandwidth_chargemode" = "traffic",
        "bandwidth_size"       = 100,
        "bandwidth_sharetype"  = "PER",
        "eip_type"             = "5_bgp",
        "available_zone"       = ["ap-southeast-3a", "ap-southeast-3b"],
        "l4_flavor_name"       = "L4_flavor.elb.s1.small"
      })
      "kubernetes.io/elb.lb-algorithm" = "ROUND_ROBIN"
    }
  }
  spec {
    selector = {
      app = "nginx"
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}