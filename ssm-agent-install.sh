#!/bin/bash
sudo mkdir /tmp/ssm
cd /tmp/ssm
sudo wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
sudo snap start amazon-ssm-agent
sudo dpkg -i amazon-ssm-agent.deb

# curl https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb -o /tmp/ssm/amazon-ssm-agent.deb
# sudo dpkg -i /tmp/ssm/amazon-ssm-agent.deb
# sudo service amazon-ssm-agent stop
# sudo -E amazon-ssm-agent -register -code "activation-code" -id "activation-id" -region "region" 
# sudo service amazon-ssm-agent start


# #snap
# #sudo systemctl enable amazon-ssm-agent
# #rm amazon-ssm-agent.deb


# ####

# #sudo apt-get update


