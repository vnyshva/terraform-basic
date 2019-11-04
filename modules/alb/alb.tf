resource "aws_alb" "alb" {
  name = "${var.STACK}"
  internal = false
  security_groups = ["${split(",", var.ALB_SG)}"]
  subnets = ["${split(",", var.ALB_SUBNETS)}"]
  tags {
    NAME = "${var.STACK} LOAD BALANCER"
    Description = "${var.STACK} application load balancer to manage node and HTTPS/HTTP termination"
  }
}


#.............
# ALB Target group

###/Login

resource "aws_alb_target_group" "nexus-ecs" {
  name = "${var.STACK}-target-group"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "/"
    protocol = "HTTP"
    port = "${var.TARGET_GROUP_PORT}"
  }
  tags {
    Name = "${var.STACK} TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
  }
}

resource "aws_alb_listener" "nexus" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port = "${var.ALB_LISTNER_PORT}"
  protocol = "${var.ALB_LISTNER_PROTOCOL}"
  ssl_policy = "${var.ALB_LISTNER_SSL_POLICY_NAME}"
  certificate_arn = "${var.ALB_CERTIFICATE_ARN}"

  default_action {
    target_group_arn = "${aws_alb_target_group.nexus-ecs.arn}"
    type = "forward"
  }

  depends_on = ["aws_alb_target_group.nexus-ecs"]
}


resource "aws_alb_listener_rule" "nexus" {
  listener_arn = "${aws_alb_listener.nexus.arn}"
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.nexus-ecs.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/"]
  }
}
