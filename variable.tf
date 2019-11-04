#
# COMMON VARIABLES
#

variable "AWS_REGION" {
  description = "aws region"
}
variable "STACK" {
  description = "name of your STACK"
}
##
variable "VPC_ID" {
  description = "vpc ID"
}

#variable "VPC_CIDR" {
#  description = "vpc cidr range"
#}

variable "PUBLIC_SUBNET_ZONEA_ID" {
  description = "public subnet cidr range"
}
variable "PUBLIC_SUBNET_ZONEB_ID" {
  description = "public subnet cidr range"
}

variable "PUBLIC_SUBNET_ZONEC_ID" {
  description = "public subnet cidr range"
}

variable "AVAILABLITY_ZONE_A" {
  description = "availablity zone for public region"
}
variable "AVAILABLITY_ZONE_B" {
  description = "availablity zone for public region"
}

#variable "PRIVATE_SUBNET_ZONEA_CIDR" {
 # description = "private subnet cidr range"
#}
#variable "PRIVATE_SUBNET_ZONEB_CIDR" {
#  description = "private subnet cidr range"
#}



##################################################################
##
## ALB VARIABLES CONFIGURATIONS
##
variable "TARGET_GROUP_PROTOCOL" {
  description = "protocol for target group"
}
variable "nexus-TG" {
  description = "target group arn"
}
variable "TARGET_GROUP_PORT" {
  description = "target group listner port from alb"
}
variable "TARGET_GROUP_HEALTH_CHECK_INTERVAL" {
  description = "interval between two consecutive healtcheck"
}
variable "TARGET_GROUP_HEALTH_CHECK_TIMEOUT" {
  description = "healtcheck time out"
}
variable "TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD" {
  description = "healthy threshold percentage"
}
variable "TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD" {
  description = "unhealthy threshold"
}
variable "HEALTHCHECK_PATH" {
  description = "target group instance healthcheck path"
}
variable "SERVICE_TARGET_GROUP_PORT" {
  description = "Target Group Port for services "
}
variable "ALB_LISTNER_PORT" {
  description = "listner port for alb"
}
variable "ALB_LISTNER_PROTOCOL" {
  description = "listner protocol for alb"
}
variable "ALB_LISTNER_SSL_POLICY_NAME" {
  description = "AWS SSL policy name"
}
variable "ALB_CERTIFICATE_ARN" {
  description = "aws certificate manager arn"
}
##########################################################
##
## RDS VARIABLE CONFIGURATIONS
##

##
## MQ variables
##


variable "KEYPAIR_NAME" {
  description = "instance key pair name"
}
variable "HEALTH_CHECK_GRACE_PERIOD" {
  description = "HEALTH CHECK GRACE PERIOD"
}
variable "HEALTH_CHECK_TYPE" {
  description = "HEALTH CHECK TYPE"
}
##
## ECS VARIABLE CONFIGURATION
##

variable "CLUSTER_NAME" {
  description = "Name of ECS cluster"
}

variable "ECS_DESIRED_COUNT" {
  description = "ecs service desired task count"
}
variable "ECS_MINIMUM_HEALTH_PERCENTAGE" {
  description = "ecs service deployment minimum health percentage"
}

##
## ECS Host
##

variable "SERVICE_ECS_INSTANCE_TYPE" {
  description = "ecs instance type"
}
variable "ECS_INSTANCE_IMAGE_ID" {
  description = "isntance ami id"
}
variable "SERVICE_INSTANCE_PUBLICIP_ASSOCIATION" {
  description = "associate public IP or not"
}
variable "SERVICE_ECS_INSTANCE_VOLUME_SIZE" {
  description = "instance disk space"
}

variable "SERVICE_ECS_INSTANCE_MIN_SIZE" {
  description = "autoscaling group min size"
}
#variable "PUBLIC_SUBNET_ZONEA_ID" {
#  description = "subnet zone A"
#}

#variable "PUBLIC_SUBNET_ZONEB_ID" {
#  description = "subnet zone B"
#}

#variable "PUBLIC_SUBNET_ZONEC_ID" {
#  description = "subnet zone C"
#}

variable "ALB_SG1" {
  description = "ALB sg1"
}

variable "ALB_SG2" {
  description = "ALB sg2"
}

variable "ALB_SG" {
  description = "ALB sg"
}

variable "ALB_SUBNETS" {
  description = "ALB subnets"
}

variable "SERVICE_ECS_INSTANCE_MAX_SIZE" {
  description = "autoscaling group max size"
}
variable "SERVICE_ECS_INSTANCE_DESIRED_CAPACITY" {
  description = "autoscaling group desired capacity"
}
variable "ECS_INSTANCE_HEALTH_CHECK_TYPE" {
  description = "instance health check type for auto scaling group"
}
