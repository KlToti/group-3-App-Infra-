#!bin/bash -x

# 1. Install Metricbeat
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
sudo apt-get update && sudo apt-get install metricbeat
sudo systemctl enable metricbeat

# 2. Replace configuration file
cat <<'EOT' >> ~/metricbeat.yml
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
#setup.template.settings:
  #index.number_of_shards: 1
  #index.codec: best_compression
  #_source.enabled: false

# ================================== Outputs ===================================
# ------------------------------ Logstash Output -------------------------------

output.logstash:
  hosts: ["LOGSTASH_IP:5044"]
  # loadbalance: true
  # ssl.enabled: true

# logging
logging.level: debug
EOT

# replace with Logstash IP address
sed -i "s/LOGSTASH_IP/${logstash_ip}/g" ~/metricbeat.yml

# copy to configuration folder
sudo cp ~/metricbeat.yml /etc/metricbeat/metricbeat.yml

# 3. Start metricbeat
sudo systemctl enable metricbeat
sudo systemctl start metricbeat