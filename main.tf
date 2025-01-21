
resource "aws_instance" "my-ec2-vm" {
  ami           = data.aws_ami.amzlinux.id 
  instance_type = var.instance_type
  key_name      = "user1"
  user_data = file("apache-install-script.sh")  
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  tags = {
    "Name" = "vm-${terraform.workspace}-0"
  }

}


output "ec2_instance_public_IP" {
  description = "Public IP Addressess of EC2 Instances"
  value = aws_instance.my-ec2-vm.*.public_ip
}