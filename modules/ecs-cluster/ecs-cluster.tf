# ECS Cluster
#
resource "aws_ecs_cluster" "nexus-ecs" {
  name = "${var.CLUSTER_NAME}"
}

#
# ECS Service Depends_On Iam roles and Policy
#
resource "aws_iam_role_policy" "ecs_role_policy" {
  name = "${var.STACK}ECS_DEPENDS_ROLE_POLICY_ZONEA"
  role = "${aws_iam_role.ecs_role.id}"

  policy = "${file("${path.module}/policies/ecs-service-role-policy.json")}"
}

resource "aws_iam_role" "ecs_role" {
  name = "${var.STACK}-ECS_DEPENDS_ROLE-ZONEA"

  assume_role_policy = "${file("${path.module}/policies/ecs-service-role.json")}"
}
#....................................
# Tak Definitions
#

#Frontends ..........................
resource "aws_ecs_task_definition" "nexus-ecs" {
  family = "nexus"
  container_definitions = "${file("${path.module}/task-definition/nexus-taskdefinition.json")}"

 volume {
    name      = "efs"
    host_path = "/efs/nexus"
  }
}
#resource "aws_ecs_task_definition" "nexus-ecs2" {
#  family = "nexus"
#  container_definitions = "${file("${path.module}/task-definition/nexus-taskdefinition2.json")}"
# 
# volume {
#    name      = "efs"
#    host_path = "/efs/nexus"
#  }
#}

#....................................................................................................
## ECS Service
#...................................................................................................
#===============================================

#Frontend
resource "aws_ecs_service" "nexus-ecs" {
  name = "nexus-ecs"
  cluster = "${aws_ecs_cluster.nexus-ecs.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.nexus-ecs.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.nexus-TG}"
    container_name = "nexus-ecs"
    container_port = "${var.TARGET_GROUP_PORT}"
  }


}
#resource "aws_ecs_service" "nexus-ecs2" {
#  name = "nexus-ecs2"
#  cluster = "${aws_ecs_cluster.nexus-ecs.id}"
#  iam_role = "${var.ECS_SERVICE_ROLE}"
#  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
#  task_definition = "${aws_ecs_task_definition.nexus-ecs2.arn}"
#  desired_count = "${var.ECS_DESIRED_COUNT}"
#  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"
#
#  load_balancer {
#    target_group_arn = "${var.nexus-TG}"
#    container_name   = "nexus-ecs2"
#    container_port   = "${var.TARGET_GROUP_PORT}"
#  }
#}
