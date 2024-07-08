#This Terraform Code Deploys Basic VPC Infra.





terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.57.0"
    }
  }
}


////////////////AWS VPC///////////////////////////////////

resource "aws_vpc" "example" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "tf-example"
  }
}



resource "aws_instance" "testing" {
  ami           = "ami-0740aeaa53d2ea48a"
  instance_type = "t4g.small"
  subnet_id     = aws_subnet.example.id

  cpu_options {
    core_count       = 1
    threads_per_core = 1
  }

  tags = {
    Name = "tf-example"
  }
}
