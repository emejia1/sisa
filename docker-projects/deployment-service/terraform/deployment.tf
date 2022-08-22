resource "kubernetes_deployment" "emejia" {
  metadata {
    name = "dpy-emejia"
    labels = {
      test = "emejia"
    }
    namespace = "ns-emejia"
  }

  spec {
    replicas = 1

    strategy {
      type = "RollingUpdate"
    }

    selector {
      match_labels = {
        test = "emejia"
      }
    }

    template {
      metadata {
        labels = {
          test = "emejia"
        }
      }

      spec {
        container {
          image = "emejia-jdk16:0.0.1"
          name  = "emejia-container"

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