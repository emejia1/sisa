resource "kubernetes_namespace" "devops" {
  metadata {
    name = "ns-devops"
  }
}