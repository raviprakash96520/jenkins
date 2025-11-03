module "jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name = "jenkins"

  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-07a2db2daca608740"] # Replace with your SG
  subnet_id              = "subnet-0bd0c13c7948c0a03" # Replace with your Subnet
  ami                    = data.aws_ami.ami_info.id
  user_data              = file("jenkins.sh")

  tags = {
    Name = "jenkins"
  }

  # Define the root volume (object syntax for v6+)
  root_block_device = {
    volume_size           = 50        # Size of the root volume in GB
    volume_type           = "gp3"     # General Purpose SSD
    delete_on_termination = true      # Auto-delete volume when terminated
  }
}

module "jenkins_agent" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name = "jenkins-agent"

  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-0cd21ec2d697dea85"] # Replace with your SG
  subnet_id              = "subnet-0bd0c13c7948c0a03" # Replace with your Subnet
  ami                    = data.aws_ami.ami_info.id
  user_data              = file("jenkins-agent.sh")

  tags = {
    Name = "jenkins-agent"
  }

  # Define the root volume (object syntax for v6+)
  root_block_device = {
    volume_size           = 50
    volume_type           = "gp3"
    delete_on_termination = true
  }
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  # ✅ Use Zone ID directly to avoid “multiple hosted zones” error
  zone_id = "Z0939587KWYCIJ7J4839" # 👈 Replace this with your actual Hosted Zone ID

  records = [
    {
      name    = "jenkins"
      type    = "A"
      ttl     = 60
      records = [module.jenkins.public_ip]
      allow_overwrite = true
    },
    {
      name    = "jenkins-agent"
      type    = "A"
      ttl     = 60
      records = [module.jenkins_agent.private_ip]
      allow_overwrite = true
    }
  ]
}
