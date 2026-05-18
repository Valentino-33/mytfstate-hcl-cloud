#!/bin/bash

echo "deploying new ec2 instance"

apt update -y > /tmp/updates.txt && apt upgrade -y > /tmp/upgrades.txt
apt install -y apache2 && systemctl enable httpd && systemctl start httpd > /tmp/apacheinstall.txt