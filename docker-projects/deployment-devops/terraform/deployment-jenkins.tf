resource "kubernetes_deployment" "jenkins" {
  metadata {
    name = "dpy-jenkins"
    labels = {
      app = "devops"
    }
    namespace = "ns-devops"
  }

  spec {
    replicas = 1

    strategy {
      type = "RollingUpdate"
    }

    selector {
      match_labels = {
        app = "devops"
      }
    }

    template {
      metadata {
        labels = {
          app = "devops"
        }
      }

      spec {
        container {
          image = "jenkins-blue:0.0.1"
          name  = "jenkins-container"

          resources {
            limits = {
              cpu    = "0.7"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "124Mi"
            }
          }
        }
      }
    }
  }
}