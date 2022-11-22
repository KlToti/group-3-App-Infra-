#!/bin/bash

#export AWS_PROFILE=final-project
#export AWS_DEFAULT_REGION=eu-central-1

# Use Debian
# https://logit.io/sources/configure/filebeat/

# 1. Install Filebeat



# 2. Copy configuration file
cd ~
sudo cat <<EOT >> filebeat.yml
# ============================== Filebeat inputs ==============================
filebeat.inputs:

- type: log

  # Change to true to enable this input configuration.
  enabled: true

  # Paths to send data from
  paths:
  - ["/var/log/syslog*"]
# ============================== Filebeat modules ==============================

filebeat.config.modules:
  # Glob pattern for configuration loading
  path: $${path.config}/modules.d/*.yml

  # Set to true to enable config reloading
  reload.enabled: false

  # Period on which files under path should be checked for changes
  #reload.period: 10s

- module: system
  syslog:
    enabled: true
    var.paths: ["/path/to/log/syslog*"]
  auth:
    enabled: true
    var.paths: ["/path/to/log/auth.log*"]

# ================================== Outputs ===================================
# ------------------------------ Logstash Output -------------------------------

output.logstash:
    hosts: ["$${LOGSTASH_IP:5044}"]
    loadbalance: true
    ssl.enabled: true

# ================================= Processors =================================
processors:
  - add_host_metadata:
      when.not.contains.tags: forwarded
  - add_cloud_metadata: ~
  - add_docker_metadata: ~
  - add_kubernetes_metadata: ~
EOT

sudo cp ~/filebeat.yml /var/log/filebeat.yml

# 3. Start Filebeat
sudo systemctl enable filebeat
sudo systemctl start filebeat