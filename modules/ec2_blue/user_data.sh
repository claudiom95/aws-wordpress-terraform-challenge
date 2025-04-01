#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -xe

# Wait for apt locks to be released (max 60s)
for i in {1..30}; do
  fuser /var/lib/dpkg/lock >/dev/null 2>&1 || break
  echo "Waiting for apt lock..."
  sleep 2
done

# Install Docker and dependencies
apt-get update -y
apt-get install -y docker.io curl jq unzip

# Install CloudWatch Agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i amazon-cloudwatch-agent.deb

# Create CloudWatch config
mkdir -p /opt/aws/amazon-cloudwatch-agent/etc
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
    container_name: wordpress_app_blue
    restart: always
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: "${db_host}"
      WORDPRESS_DB_NAME: "${db_name}"
      WORDPRESS_DB_USER: "${db_username}"
      WORDPRESS_DB_PASSWORD: "${db_password}"
EOF

# Ensure the ubuntu user owns the file
chown ubuntu:ubuntu /home/ubuntu/docker-compose.yml

# Run Docker Compose
cd /home/ubuntu
sudo docker-compose up -d

# Done