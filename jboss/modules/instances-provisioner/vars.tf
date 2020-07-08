variable "ENV" {
}

variable "APP" {
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "PUBLIC_SUBNETS" {
  type = list
}

variable "VPC_ID" {
}

variable "PATH_TO_PRIVATE_KEY" {
	default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "PATH_SCRIPT" {
  default = "scripts/install_software.sh"
}

variable "PATH_CONF" {
  default = "conf"
}

variable "INSTANCE_USERNAME" {
	default = "ubuntu"
}

