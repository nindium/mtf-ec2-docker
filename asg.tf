

data "aws_ami" "amazon_linux_2" {
 most_recent = true
 owners = ["amazon"]
 

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

data "template_file" "bootstrap_data" {
    template = <<-EOF
              #!/bin/bash
              yum update -y
              yum install docker -y
              systemctl enable docker
              systemctl start docker
              docker pull nindium/myapp
              docker run -dp 80:80 --name volcanoes nindium/myapp
              EOF
}

resource "aws_launch_template" "asg_ltemplate" {
    name = "docker_host"
    image_id = data.aws_ami.amazon_linux_2.id
    instance_type = "t2.micro"
    key_name = var.ec2_key_name
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    user_data = base64encode(data.template_file.bootstrap_data.rendered)
    #user_data = "${base64encode(data.template_file.bootstrap_data.rendered)}"
}

resource "aws_autoscaling_group" "web_asg" {
  vpc_zone_identifier = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[1].id]
  launch_template {
    id = aws_launch_template.asg_ltemplate.id
    version = aws_launch_template.asg_ltemplate.latest_version
  }
  health_check_type         = "ELB"
  desired_capacity   = var.asg_desired_capacity
  max_size           = var.asg_desired_capacity
  min_size           = var.asg_desired_capacity
  target_group_arns         = [aws_lb_target_group.web-target.arn]
}
