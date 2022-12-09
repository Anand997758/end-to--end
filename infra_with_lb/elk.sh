wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee –a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update
sudo apt-get install elasticsearch
sudo vi /etc/elasticsearch/elasticsearch.yml
#vi /etc/elasticsearch/elasticsearch.yml

sudo apt-get install kibana
#sudo vi /etc/kibana/kibana.yml

