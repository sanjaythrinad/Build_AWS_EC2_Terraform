vpc_name = "devop-project1-vpv"
vpc_cidr_block = "10.0.0.0/16"
subnet_name = "devop-project1-subnet"
subnet_cidr_block = "10.0.1.0/24"
region = "us-east-1"
availability_zone = "us-east-1a"
instance_ami = "ami-04b70fa74e45c3917"
instance_type = "t2.micro"
server_name = "project-1_server"

# export TF_VAR_public_key=$(cat ~/.ssh/id_rsa.pub)