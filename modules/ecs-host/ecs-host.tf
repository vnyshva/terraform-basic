
#.................................................................
# User data template that specifies how to bootstrap each instance
#..................................................................
data "template_file" "nexus" {
  template = "${file("${path.module}/user-data.tpl")}"

  vars {
    cluster_name = "${var.CLUSTER_NAME}"

  }
}
#............................................................................
# The launch configuration for each EC2 Instance that will run in the cluster
#............................................................................

resource "aws_launch_configuration" "nexus" {
  name_prefix = "${var.CLUSTER_NAME}"
  instance_type = "${var.SERVICE_ECS_INSTANCE_TYPE}"
  iam_instance_profile = "${var.SERVICE_ECS_INSTANCE_PROFILE}"
  key_name = "${var.KEY_PAIR_NAME}"
  security_groups = ["${var.SERVICE-SG}"]
  image_id = "${var.ECS_INSTANCE_IMAGE_ID}"
  user_data = "${data.template_file.nexus.rendered}"
  associate_public_ip_address = "${var.SERVICE_INSTANCE_PUBLICIP_ASSOCIATION}"
  root_block_device { 
         volume_size = "${var.SERVICE_ECS_INSTANCE_VOLUME_SIZE}"
         delete_on_termination = true
  }
  lifecycle { create_before_destroy = true }
}
#......................................................................................................
# The auto scaling group that specifies how we want to scale the number of EC2 Instances in the cluster
#......................................................................................................


resource "aws_autoscaling_group" "nexus" {
  name = "${var.STACK}"
  min_size = "${var.SERVICE_ECS_INSTANCE_MIN_SIZE}"
  max_size = "${var.SERVICE_ECS_INSTANCE_MAX_SIZE}"
  desired_capacity = "${var.SERVICE_ECS_INSTANCE_DESIRED_CAPACITY}"
  force_delete = true
  launch_configuration = "${aws_launch_configuration.nexus.name}"
  vpc_zone_identifier = ["${split(",", var.SERVICE_ECS_INSTANCE_SUBNET_ZONEA)}"]
  health_check_type = "${var.ECS_INSTANCE_HEALTH_CHECK_TYPE}"
  
  lifecycle { create_before_destroy = true }

  tag {
    key = "Name"
    value = "${var.STACK}"
    propagate_at_launch = true
  }
  tag {
    key = "Description"
    value = "Ec2 linux runnning ${var.CLUSTER_NAME} docker containers"
    propagate_at_launch = true
  }
}
