output "alb_listener_arn" {
  value = "${aws_alb_listener.nexus.arn}"
}

output "nexus" {
  value = "${aws_alb_target_group.nexus-ecs.arn}"
}
