variable "CLUSTER_NAME" {
  description = "Name of ECS cluster"
}
variable "ECS_SERVICE_ROLE" {
  description = "ECS service role arn"
}
variable "TARGET_GROUP_PORT" {
  description = "service load balancer port"
}
variable "SERVICE_TARGET_GROUP_PORT" {
  description = "service load balancer port"
}

variable "ECS_DESIRED_COUNT" {
  description = "ecs service desired task count"
}
variable "ECS_MINIMUM_HEALTH_PERCENTAGE" {
  description = "ecs service deployment minimum health percentage"
}

variable "STACK" {
  description = "stack name"
}
variable "nexus-TG" {
  description = "Target Group Name"
}

