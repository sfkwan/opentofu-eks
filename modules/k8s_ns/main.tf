resource "kubernetes_namespace" "my-app-ns" {
  metadata {
    name = var.k8s_namespace
  }

}
