# Terraform Generic Modules which are interconnected and
# can be deployed independently.

#==================================================
#
# Configure the AWS Provider
#

provider "aws" {
  region = "${var.AWS_REGION}"
  shared_credentials_file = "./modules/credentials"

}


#=====================================================
#
# vpc configuration module
#
##module "vpc" {
## source = "./modules/vpc"
# #VPC_CIDR = "${var.VPC_CIDR}"
## AVAILABLITY_ZONE_A = "${var.AVAILABLITY_ZONE_A}"
## AVAILABLITY_ZONE_B = "${var.AVAILABLITY_ZONE_B}"
## PUBLIC_SUBNET_ZONEA_CIDR = "${var.PUBLIC_SUBNET_ZONEA_CIDR}"
## PUBLIC_SUBNET_ZONEB_CIDR = "${var.PUBLIC_SUBNET_ZONEB_CIDR}"
## PRIVATE_SUBNET_ZONEA_CIDR = "${var.PRIVATE_SUBNET_ZONEA_CIDR}"
##  PRIVATE_SUBNET_ZONEB_CIDR = "${var.PRIVATE_SUBNET_ZONEB_CIDR}"
##  STACK = "${var.STACK}"
##}
#======================================================

#
# Security Groups configuration module
#
#module "firewall" {
#  source = "./modules/firewall"
#  VPC_ID = "${module.vpc.vpc_id}"
#  STACK = "${var.STACK}"
#}
#=======================================================
#
# Application Load Balancer configuration module
#

module "alb" {
  source = "./modules/alb"

  VPC_ID = "${var.VPC_ID}"

  ALB_CERTIFICATE_ARN = "${var.ALB_CERTIFICATE_ARN}"
  ALB_LISTNER_SSL_POLICY_NAME = "${var.ALB_LISTNER_SSL_POLICY_NAME}"
  ALB_LISTNER_PORT = "${var.ALB_LISTNER_PORT}"
  ALB_LISTNER_PROTOCOL = "${var.ALB_LISTNER_PROTOCOL}"
  ALB_SG = "${var.ALB_SG}"
  ALB_SUBNETS = "${var.ALB_SUBNETS}"

  TARGET_GROUP_PORT = "${var.TARGET_GROUP_PORT}"
  TARGET_GROUP_PROTOCOL = "${var.TARGET_GROUP_PROTOCOL}"
  SERVICE_TARGET_GROUP_PORT = "${var.SERVICE_TARGET_GROUP_PORT}"
  TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
  TARGET_GROUP_HEALTH_CHECK_INTERVAL = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
  TARGET_GROUP_HEALTH_CHECK_TIMEOUT = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
  TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
  HEALTHCHECK_PATH = "${var.HEALTHCHECK_PATH}"

  STACK = "${var.STACK}"
}

module "policy" {
  source = "./modules/policy"

  STACK = "${var.STACK}"
}

module "ecs-host" {
  source = "./modules/ecs-host"
  STACK = "${var.STACK}"
  CLUSTER_NAME = "${var.CLUSTER_NAME}"
  SERVICE-SG = "${var.ALB_SG1}"
  SERVICE_ECS_INSTANCE_SUBNET_ZONEA = "${var.PUBLIC_SUBNET_ZONEA_ID}"
  SERVICE_ECS_INSTANCE_SUBNET_ZONEB = "${var.PUBLIC_SUBNET_ZONEB_ID}"
  SERVICE_ECS_INSTANCE_DESIRED_CAPACITY = "${var.SERVICE_ECS_INSTANCE_DESIRED_CAPACITY}"
  SERVICE_ECS_INSTANCE_MIN_SIZE = "${var.SERVICE_ECS_INSTANCE_MIN_SIZE}"
  SERVICE_ECS_INSTANCE_MAX_SIZE = "${var.SERVICE_ECS_INSTANCE_MAX_SIZE}"
  SERVICE_ECS_INSTANCE_PROFILE = "${module.policy.ecs_instance_profile_name}"
  SERVICE_ECS_INSTANCE_TYPE = "${var.SERVICE_ECS_INSTANCE_TYPE}"
  SERVICE_ECS_INSTANCE_VOLUME_SIZE = "${var.SERVICE_ECS_INSTANCE_VOLUME_SIZE}"
  SERVICE_INSTANCE_PUBLICIP_ASSOCIATION = "${var.SERVICE_INSTANCE_PUBLICIP_ASSOCIATION}"
  ECS_INSTANCE_HEALTH_CHECK_TYPE = "${var.ECS_INSTANCE_HEALTH_CHECK_TYPE}"
  ECS_INSTANCE_IMAGE_ID = "${var.ECS_INSTANCE_IMAGE_ID}"
  KEY_PAIR_NAME = "${var.KEYPAIR_NAME}"
}

module "ecs-cluster" {
  source = "./modules/ecs-cluster"

  CLUSTER_NAME = "${var.CLUSTER_NAME}"
  nexus-TG = "${module.alb.nexus}"
  ECS_SERVICE_ROLE = "${module.policy.ecs_service_role_arn}"
  TARGET_GROUP_PORT = "${var.TARGET_GROUP_PORT}"
  SERVICE_TARGET_GROUP_PORT = "${var.SERVICE_TARGET_GROUP_PORT}"
  ECS_DESIRED_COUNT = "${var.ECS_DESIRED_COUNT}"
  ECS_MINIMUM_HEALTH_PERCENTAGE = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  STACK = "${var.STACK}"
}
