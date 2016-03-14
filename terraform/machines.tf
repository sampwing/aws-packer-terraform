resource "aws_key_pair" "deploy" {
	key_name = "deploy"
	public_key = "${file("id_rsa.pub")}"
}

resource "aws_instance" "development" {
    ami = "${lookup(var.amis, var.region)}" 
    instance_type = "t2.nano"
	vpc_security_group_ids = [
		"${aws_security_group.sg_development.id}"
	]
	subnet_id = "${aws_subnet.public.id}"
	associate_public_ip_address = true
	key_name = "${aws_key_pair.deploy.key_name}"
}
