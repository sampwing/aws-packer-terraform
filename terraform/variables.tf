variable "access_key" {
	description = "AWS Access Key Id"
}

variable "secret_key" {
	description = "AWS Secret Access Key"
}

variable "region" {
	description = "AWS Region"
    default = "us-west-1"
}

variable "amis" {
	description = "AWS AMIs"
    default = {
        us-west-1 = "ami-33235353"
    }
}
