resource "kubernetes_service" "jenkins" {
  metadata {
    name = "scv-jenkins"
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
      name        = "port1"
      node_port   = 30392
      port        = 8080
      target_port = 8080
    }

    port {
      name        = "port2"
      node_port   = 30393
      port        = 5000
      target_port = 5000
    }

  }
}