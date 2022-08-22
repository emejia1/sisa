resource "kubernetes_namespace" "example" {
  metadata {
    name = "k8s-ns-sisa"
  }
}

resource "kubernetes_deployment" "example" {
  metadata {
    name = "terraform-sisa"
    labels = {
      test = "sisa-deployment"
    }
    namespace = "k8s-ns-sisa"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "sisa-deployment"
      }
    }

    template {
      metadata {
        labels = {
          test = "sisa-deployment"
        }
      }

      spec {
        container {
          image = "adoptopenjdk/openjdk16"
          name  = "sisamicroservices"

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
        }
      }
    }
  }
}