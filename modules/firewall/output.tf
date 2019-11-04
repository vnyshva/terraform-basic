output "ssl_sg_id" {
  value = "${aws_security_group.ssl.id}"
}
output "docker_sg_id" {
  value = "${aws_security_group.docker.id}"
}
output "admin_sg_id" {
  value = "${aws_security_group.admin.id}"
}
