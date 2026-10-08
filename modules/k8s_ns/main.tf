resource "kubernetes_namespace_v1" "my-app-ns" {
  metadata {
    name = var.k8s_namespace
  }

}
