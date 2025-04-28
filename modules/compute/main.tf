# EC2 인스턴스
resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = var.security_group_ids

  user_data = <<-EOF
              #!/bin/bash
              # 로그 설정
              exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
              
              # 시스템 업데이트
              apt-get update -y
              apt-get install -y curl
              echo "System updated"
              # ubuntu 사용자로 Volta 설치
              su - ubuntu -c 'curl https://get.volta.sh | bash'
              
              # ubuntu 사용자의 .bashrc에 Volta 환경변수 추가
              echo 'export VOLTA_HOME="$HOME/.volta"' >> /home/ubuntu/.bashrc
              echo 'export PATH="$VOLTA_HOME/bin:$PATH"' >> /home/ubuntu/.bashrc
              
              # ubuntu 사용자로 Node.js 설치
              su - ubuntu -c 'source $HOME/.bashrc && volta install node'
              
              echo "Installation completed"
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "${var.app_name}-instance"
  }
}
