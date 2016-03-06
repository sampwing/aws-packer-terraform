resource "aws_key_pair" "deploy" {
	key_name = "deploy"
	public_key = "${file("id_rsa.pub")}"
}

resource "aws_instance" "web" {
    ami = "${lookup(var.amis, var.region)}" 
    instance_type = "t2.nano"
	vpc_security_group_ids = [
		"${aws_security_group.sg_web.id}"
	]
	subnet_id = "${aws_subnet.public.id}"
	associate_public_ip_address = true
	key_name = "${aws_key_pair.deploy.key_name}"
    provisioner "remote-exec" {
        inline = [
			"sudo mkdir -p /srv/www",
			"sudo chown ubuntu:ubuntu /srv/www",
			"cd /srv/www",
			"echo 'Hello from python' > index.html",
			"python2 -m SimpleHTTPServer &"
		]
		connection {
			user = "ubuntu"
			private_key = "${file("id_rsa")}"
			timeout = "10m"
		}
    }
}
