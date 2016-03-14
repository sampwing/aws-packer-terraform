# setup vpc
resource "aws_vpc" "vpc_development" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "igw_development" {
    vpc_id = "${aws_vpc.vpc_development.id}"
}

resource "aws_subnet" "public" {
    vpc_id = "${aws_vpc.vpc_development.id}"
    cidr_block = "10.0.0.0/24"
}

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.vpc_development.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw_development.id}"
    }
}

resource "aws_route_table_association" "public" {
    subnet_id = "${aws_subnet.public.id}"
    route_table_id = "${aws_route_table.public.id}"
}

# security groups
resource "aws_security_group" "sg_development" {
	name = "sg_development"
	description = "Allow ssh, redis and elasticsearch access"
	vpc_id = "${aws_vpc.vpc_development.id}"
}

resource "aws_security_group_rule" "sg_rule_ssh" {
	type = "ingress"
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]

	security_group_id = "${aws_security_group.sg_development.id}"
}

resource "aws_security_group_rule" "sg_rule_redis" {
	type = "ingress"
	from_port = 6379
	to_port = 6379
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]

	security_group_id = "${aws_security_group.sg_development.id}"
}

resource "aws_security_group_rule" "sg_rule_elasticsearch" {
	type = "ingress"
	from_port = 9200
	to_port = 9200 
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]

	security_group_id = "${aws_security_group.sg_development.id}"
}

# eips
resource "aws_eip" "ip" {
    instance = "${aws_instance.development.id}"
  	depends_on = ["aws_instance.development"]
}
