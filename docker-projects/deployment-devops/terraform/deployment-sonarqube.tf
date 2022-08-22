resource "kubernetes_deployment" "sonarqube" {
  metadata {
    name = "dpy-sonarqube"
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
          image = "sonarqube"
          name  = "sonarqube-container"

          
        }
      }
    }
  }
}