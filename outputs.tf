output "horizontal_pod_autoscaler_v2beta2s_id" {
  description = "Map of id values across all horizontal_pod_autoscaler_v2beta2s, keyed the same as var.horizontal_pod_autoscaler_v2beta2s except keys with no id are omitted"
  value       = { for k, v in kubernetes_horizontal_pod_autoscaler_v2beta2.horizontal_pod_autoscaler_v2beta2s : k => v.id if v.id != null && length(v.id) > 0 }
}
output "horizontal_pod_autoscaler_v2beta2s_metadata" {
  description = "Map of metadata values across all horizontal_pod_autoscaler_v2beta2s, keyed the same as var.horizontal_pod_autoscaler_v2beta2s except keys with no metadata are omitted"
  value       = { for k, v in kubernetes_horizontal_pod_autoscaler_v2beta2.horizontal_pod_autoscaler_v2beta2s : k => one(v.metadata) if v.metadata != null && length(v.metadata) > 0 }
}
output "horizontal_pod_autoscaler_v2beta2s_spec" {
  description = "Map of spec values across all horizontal_pod_autoscaler_v2beta2s, keyed the same as var.horizontal_pod_autoscaler_v2beta2s except keys with no spec are omitted"
  value       = { for k, v in kubernetes_horizontal_pod_autoscaler_v2beta2.horizontal_pod_autoscaler_v2beta2s : k => one(v.spec) if v.spec != null && length(v.spec) > 0 }
}

