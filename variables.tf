variable "horizontal_pod_autoscaler_v2beta2s" {
  description = <<EOT
Map of horizontal_pod_autoscaler_v2beta2s, attributes below
Required:
    - metadata (block):
        - annotations (optional)
        - generate_name (optional)
        - labels (optional)
        - name (optional)
        - namespace (optional)
    - spec (block):
        - behavior (optional, block):
            - scale_down (optional, block):
                - policy (required, block):
                    - period_seconds (required)
                    - type (required)
                    - value (required)
                - select_policy (optional)
                - stabilization_window_seconds (optional)
            - scale_up (optional, block):
                - policy (required, block):
                    - period_seconds (required)
                    - type (required)
                    - value (required)
                - select_policy (optional)
                - stabilization_window_seconds (optional)
        - max_replicas (required)
        - metric (optional, block):
            - container_resource (optional, block):
                - container (required)
                - name (required)
                - target (optional, block):
                    - average_utilization (optional)
                    - average_value (optional)
                    - type (required)
                    - value (optional)
            - external (optional, block):
                - metric (required, block):
                    - name (required)
                    - selector (optional, block):
                        - match_expressions (optional, block):
                            - key (optional)
                            - operator (optional)
                            - values (optional)
                        - match_labels (optional)
                - target (optional, block):
                    - average_utilization (optional)
                    - average_value (optional)
                    - type (required)
                    - value (optional)
            - object (optional, block):
                - described_object (required, block):
                    - api_version (required)
                    - kind (required)
                    - name (required)
                - metric (required, block):
                    - name (required)
                    - selector (optional, block):
                        - match_expressions (optional, block):
                            - key (optional)
                            - operator (optional)
                            - values (optional)
                        - match_labels (optional)
                - target (optional, block):
                    - average_utilization (optional)
                    - average_value (optional)
                    - type (required)
                    - value (optional)
            - pods (optional, block):
                - metric (required, block):
                    - name (required)
                    - selector (optional, block):
                        - match_expressions (optional, block):
                            - key (optional)
                            - operator (optional)
                            - values (optional)
                        - match_labels (optional)
                - target (optional, block):
                    - average_utilization (optional)
                    - average_value (optional)
                    - type (required)
                    - value (optional)
            - resource (optional, block):
                - name (required)
                - target (optional, block):
                    - average_utilization (optional)
                    - average_value (optional)
                    - type (required)
                    - value (optional)
            - type (required)
        - min_replicas (optional)
        - scale_target_ref (required, block):
            - api_version (optional)
            - kind (required)
            - name (required)
        - target_cpu_utilization_percentage (optional)
EOT

  type = map(object({
    metadata = object({
      annotations   = optional(map(string))
      generate_name = optional(string)
      labels        = optional(map(string))
      name          = optional(string)
      namespace     = optional(string)
    })
    spec = object({
      behavior = optional(object({
        scale_down = optional(list(object({
          policy = list(object({
            period_seconds = number
            type           = string
            value          = number
          }))
          select_policy                = optional(string)
          stabilization_window_seconds = optional(number)
        })))
        scale_up = optional(list(object({
          policy = list(object({
            period_seconds = number
            type           = string
            value          = number
          }))
          select_policy                = optional(string)
          stabilization_window_seconds = optional(number)
        })))
      }))
      max_replicas = number
      metric = optional(list(object({
        container_resource = optional(object({
          container = string
          name      = string
          target = optional(object({
            average_utilization = optional(number)
            average_value       = optional(string)
            type                = string
            value               = optional(string)
          }))
        }))
        external = optional(object({
          metric = object({
            name = string
            selector = optional(list(object({
              match_expressions = optional(list(object({
                key      = optional(string)
                operator = optional(string)
                values   = optional(set(string))
              })))
              match_labels = optional(map(string))
            })))
          })
          target = optional(object({
            average_utilization = optional(number)
            average_value       = optional(string)
            type                = string
            value               = optional(string)
          }))
        }))
        object = optional(object({
          described_object = object({
            api_version = string
            kind        = string
            name        = string
          })
          metric = object({
            name = string
            selector = optional(list(object({
              match_expressions = optional(list(object({
                key      = optional(string)
                operator = optional(string)
                values   = optional(set(string))
              })))
              match_labels = optional(map(string))
            })))
          })
          target = optional(object({
            average_utilization = optional(number)
            average_value       = optional(string)
            type                = string
            value               = optional(string)
          }))
        }))
        pods = optional(object({
          metric = object({
            name = string
            selector = optional(list(object({
              match_expressions = optional(list(object({
                key      = optional(string)
                operator = optional(string)
                values   = optional(set(string))
              })))
              match_labels = optional(map(string))
            })))
          })
          target = optional(object({
            average_utilization = optional(number)
            average_value       = optional(string)
            type                = string
            value               = optional(string)
          }))
        }))
        resource = optional(object({
          name = string
          target = optional(object({
            average_utilization = optional(number)
            average_value       = optional(string)
            type                = string
            value               = optional(string)
          }))
        }))
        type = string
      })))
      min_replicas = optional(number)
      scale_target_ref = object({
        api_version = optional(string)
        kind        = string
        name        = string
      })
      target_cpu_utilization_percentage = optional(number)
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.horizontal_pod_autoscaler_v2beta2s : (
        v.spec.behavior == null || (v.spec.behavior.scale_down == null || alltrue([for item in v.spec.behavior.scale_down : (length(item.policy) >= 1)]))
      )
    ])
    error_message = "Each policy list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.horizontal_pod_autoscaler_v2beta2s : (
        v.spec.behavior == null || (v.spec.behavior.scale_up == null || alltrue([for item in v.spec.behavior.scale_up : (length(item.policy) >= 1)]))
      )
    ])
    error_message = "Each policy list must contain at least 1 items"
  }
}

