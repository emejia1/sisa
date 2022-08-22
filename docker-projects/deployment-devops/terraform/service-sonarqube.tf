resource "kubernetes_service" "sonarqube" {
  metadata {
    name = "scv-sonarqube"
    labels = {
      app = "devops"
    }
    namespace = "ns-devops"
  }
  spec {
    type = "NodePort"

    selector = {
      app = "devops"
    }

    port {
      name        = "port3"
      node_port   = 30450
      port        = 9000
      target_port = 9000
    }

    port {
      name        = "port4"
      node_port   = 30460
      port        = 9092
      target_port = 9092
    }
  }
}