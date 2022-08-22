resource "kubernetes_service" "emejia" {
  metadata {
    name = "scv-emejia"
	labels = {
      test = "emejia"
    }
    namespace = "ns-emejia"
  }
  spec {
    type = "NodePort"

    selector = {
      test = "emejia"
    }

    port {
      node_port   = 30305
      port        = 7082
      target_port = 7082
    }

  }
}