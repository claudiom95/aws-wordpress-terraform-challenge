#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -xe

# Install Docker and dependencies
apt-get update -y
apt-get install -y docker.io curl jq unzip

# Install CloudWatch Agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i amazon-cloudwatch-agent.deb

# Create CloudWatch config
cat <<EOF > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/user-data.log",
            "log_group_name": "/wordpress/user-data",
            "log_stream_name": "{instance_id}"
          }
        ]
      }
    }
  }
}
EOF

# Start the CloudWatch Agent
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  -s

# Enable and start Docker
systemctl enable docker
systemctl start docker

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create Docker Compose file
cat <<EOF > /home/ubuntu/docker-compose.yml
services:
  wordpress:
    image: wordpress:latest
    container_name: wordpress_app
    restart: always
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: "${db_host}"
      WORDPRESS_DB_NAME: "wordpress_db"
      WORDPRESS_DB_USER: "claudio"
      WORDPRESS_DB_PASSWORD: "${db_password}"
EOF

# Ensure the ubuntu user owns the file
chown ubuntu:ubuntu /home/ubuntu/docker-compose.yml

# Run Docker Compose
cd /home/ubuntu
sudo docker-compose up -d

# Done