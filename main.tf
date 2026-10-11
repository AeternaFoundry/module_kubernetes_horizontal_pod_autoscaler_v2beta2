resource "kubernetes_horizontal_pod_autoscaler_v2beta2" "horizontal_pod_autoscaler_v2beta2s" {
  for_each = var.horizontal_pod_autoscaler_v2beta2s


  metadata {
    annotations   = each.value.metadata.annotations
    generate_name = each.value.metadata.generate_name
    labels        = each.value.metadata.labels
    name          = each.value.metadata.name
    namespace     = each.value.metadata.namespace
  }

  spec {
    dynamic "behavior" {
      for_each = each.value.spec.behavior != null ? [each.value.spec.behavior] : []
      content {
        dynamic "scale_down" {
          for_each = behavior.value.scale_down != null ? behavior.value.scale_down : []
          content {
            dynamic "policy" {
              for_each = scale_down.value.policy
              content {
                period_seconds = policy.value.period_seconds
                type           = policy.value.type
                value          = policy.value.value
              }
            }
            select_policy                = scale_down.value.select_policy
            stabilization_window_seconds = scale_down.value.stabilization_window_seconds
          }
        }
        dynamic "scale_up" {
          for_each = behavior.value.scale_up != null ? behavior.value.scale_up : []
          content {
            dynamic "policy" {
              for_each = scale_up.value.policy
              content {
                period_seconds = policy.value.period_seconds
                type           = policy.value.type
                value          = policy.value.value
              }
            }
            select_policy                = scale_up.value.select_policy
            stabilization_window_seconds = scale_up.value.stabilization_window_seconds
          }
        }
      }
    }
    max_replicas = each.value.spec.max_replicas
    dynamic "metric" {
      for_each = each.value.spec.metric != null ? each.value.spec.metric : []
      content {
        dynamic "container_resource" {
          for_each = metric.value.container_resource != null ? [metric.value.container_resource] : []
          content {
            container = container_resource.value.container
            name      = container_resource.value.name
            dynamic "target" {
              for_each = container_resource.value.target != null ? [container_resource.value.target] : []
              content {
                average_utilization = target.value.average_utilization
                average_value       = target.value.average_value
                type                = target.value.type
                value               = target.value.value
              }
            }
          }
        }
        dynamic "external" {
          for_each = metric.value.external != null ? [metric.value.external] : []
          content {
            metric {
              name = external.value.metric.name
              dynamic "selector" {
                for_each = external.value.metric.selector != null ? external.value.metric.selector : []
                content {
                  dynamic "match_expressions" {
                    for_each = selector.value.match_expressions != null ? selector.value.match_expressions : []
                    content {
                      key      = match_expressions.value.key
                      operator = match_expressions.value.operator
                      values   = match_expressions.value.values
                    }
                  }
                  match_labels = selector.value.match_labels
                }
              }
            }
            dynamic "target" {
              for_each = external.value.target != null ? [external.value.target] : []
              content {
                average_utilization = target.value.average_utilization
                average_value       = target.value.average_value
                type                = target.value.type
                value               = target.value.value
              }
            }
          }
        }
        dynamic "object" {
          for_each = metric.value.object != null ? [metric.value.object] : []
          content {
            described_object {
              api_version = object.value.described_object.api_version
              kind        = object.value.described_object.kind
              name        = object.value.described_object.name
            }
            metric {
              name = object.value.metric.name
              dynamic "selector" {
                for_each = object.value.metric.selector != null ? object.value.metric.selector : []
                content {
                  dynamic "match_expressions" {
                    for_each = selector.value.match_expressions != null ? selector.value.match_expressions : []
                    content {
                      key      = match_expressions.value.key
                      operator = match_expressions.value.operator
                      values   = match_expressions.value.values
                    }
                  }
                  match_labels = selector.value.match_labels
                }
              }
            }
            dynamic "target" {
              for_each = object.value.target != null ? [object.value.target] : []
              content {
                average_utilization = target.value.average_utilization
                average_value       = target.value.average_value
                type                = target.value.type
                value               = target.value.value
              }
            }
          }
        }
        dynamic "pods" {
          for_each = metric.value.pods != null ? [metric.value.pods] : []
          content {
            metric {
              name = pods.value.metric.name
              dynamic "selector" {
                for_each = pods.value.metric.selector != null ? pods.value.metric.selector : []
                content {
                  dynamic "match_expressions" {
                    for_each = selector.value.match_expressions != null ? selector.value.match_expressions : []
                    content {
                      key      = match_expressions.value.key
                      operator = match_expressions.value.operator
                      values   = match_expressions.value.values
                    }
                  }
                  match_labels = selector.value.match_labels
                }
              }
            }
            dynamic "target" {
              for_each = pods.value.target != null ? [pods.value.target] : []
              content {
                average_utilization = target.value.average_utilization
                average_value       = target.value.average_value
                type                = target.value.type
                value               = target.value.value
              }
            }
          }
        }
        dynamic "resource" {
          for_each = metric.value.resource != null ? [metric.value.resource] : []
          content {
            name = resource.value.name
            dynamic "target" {
              for_each = resource.value.target != null ? [resource.value.target] : []
              content {
                average_utilization = target.value.average_utilization
                average_value       = target.value.average_value
                type                = target.value.type
                value               = target.value.value
              }
            }
          }
        }
        type = metric.value.type
      }
    }
    min_replicas = each.value.spec.min_replicas
    scale_target_ref {
      api_version = each.value.spec.scale_target_ref.api_version
      kind        = each.value.spec.scale_target_ref.kind
      name        = each.value.spec.scale_target_ref.name
    }
    target_cpu_utilization_percentage = each.value.spec.target_cpu_utilization_percentage
  }
}

