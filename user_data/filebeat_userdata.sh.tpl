#!/bin/bash -x

# needs review
# 1. Install Filebeat

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
sudo apt-get update && sudo apt-get install filebeat
sudo systemctl enable filebeat

# 2. Copy configuration file

cat <<EOT >> ~/filebeat.yml
# ============================== Filebeat inputs ==============================
filebeat.inputs:
- type: log
  # Change to true to enable this input configuration.
  enabled: true

  # Paths to send data from
  paths:
  - ["/var/log/*.log"]
# ============================== Filebeat modules ==============================

filebeat.config.modules:
  # Glob pattern for configuration loading
  path: ${path.config}/modules.d/*.yml

  # Set to true to enable config reloading
  reload.enabled: false

  # Period on which files under path should be checked for changes
  #reload.period: 10s

# ================================== Outputs ===================================
# ------------------------------ Logstash Output -------------------------------

output.logstash:
    hosts: ["{LOGSTASH_IP:5044}"]
    #loadbalance: true
    #ssl.enabled: true

# logging
logging.level: debug
EOT

# replace with Logstash IP address
sed -i "s/LOGSTASH_IP/${logstash_ip}/g" ~/filebeat.yml

# copy to configuration folder
sudo cp ~/filebeat.yml /etc/filebeat/filebeat.yml

# 3. Start Filebeat
sudo systemctl enable filebeat
sudo systemctl start filebeat