output "k8s_namespace" {
  value = kubernetes_namespace_v1.my-app-ns.id
}
