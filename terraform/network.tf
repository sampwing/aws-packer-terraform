# setup vpc
resource "aws_vpc" "vpc_redis" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "igw_redis" {
    vpc_id = "${aws_vpc.vpc_redis.id}"
}

resource "aws_subnet" "public" {
    vpc_id = "${aws_vpc.vpc_redis.id}"
    cidr_block = "10.0.0.0/24"
}

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.vpc_redis.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw_redis.id}"
    }
}

resource "aws_route_table_association" "public" {
    subnet_id = "${aws_subnet.public.id}"
    route_table_id = "${aws_route_table.public.id}"
}

# security groups
resource "aws_security_group" "sg_redis" {
	name = "sg_redis"
	description = "Allow ssh and redis access"
	vpc_id = "${aws_vpc.vpc_redis.id}"
}

resource "aws_security_group_rule" "sg_rule_ssh" {
	type = "ingress"
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]

	security_group_id = "${aws_security_group.sg_redis.id}"
}

resource "aws_security_group_rule" "sg_rule_redis" {
	type = "ingress"
	from_port = 6379
	to_port = 6379
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]

	security_group_id = "${aws_security_group.sg_redis.id}"
}

# eips
resource "aws_eip" "ip" {
    instance = "${aws_instance.redis.id}"
  	depends_on = ["aws_instance.redis"]
}
