#!bin/bash

# Use Debian
# https://logit.io/sources/configure/metricbeat/

# 1. Install Metricbeat
curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-oss-7.15.1-amd64.deb
sudo dpkg -i metricbeat-oss-7.15.1-amd64.deb

# 2. Copy configuration file
cd ~
cat <<EOT >> filebeat.yml
###################### Metricbeat Configuration Example #######################
# =========================== Modules configuration ============================

metricbeat.config.modules:
  # Glob pattern for configuration loading
  path: ${path.config}/modules.d/*.yml

  # Set to true to enable config reloading
  reload.enabled: false

  # Period on which files under path should be checked for changes
  #reload.period: 10s
# ======================= Elasticsearch template setting =======================
setup.template.settings:
  index.number_of_shards: 1
  index.codec: best_compression
  #_source.enabled: false

# ================================== Outputs ===================================
# ------------------------------ Logstash Output -------------------------------

output.logstash:
  hosts: ["3.76.35.53:5044"]
  loadbalance: true
  ssl.enabled: true

# ================================= Processors =================================
processors:
  - add_host_metadata: ~
  - add_cloud_metadata: ~
  - add_docker_metadata: ~
  - add_kubernetes_metadata: ~
EOT
cp ~/filebeat.yml /var/log/filebeat.yml

# 3. Start Filebeat
sudo systemctl enable metricbeat
sudo systemctl start metricbeat