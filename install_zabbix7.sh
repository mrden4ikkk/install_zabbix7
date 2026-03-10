#!/bin/bash
set -e

# Update the system
apt update
apt upgrade -y

# Install MySQL
apt install -y mysql-server

# Enable and start MySQL service
systemctl enable mysql
systemctl start mysql

# Create Zabbix database and user
mysql -uroot <<EOF
CREATE DATABASE zabbix character set utf8mb4 collate utf8mb4_bin;
CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix';
GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';
SET GLOBAL log_bin_trust_function_creators = 1;
FLUSH PRIVILEGES;
EOF

# Download and install Zabbix 7.0 repository
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu24.04_all.deb
dpkg -i zabbix-release_7.0-2+ubuntu24.04_all.deb
apt update

# Install Zabbix server, agent, and web interface
apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

# Import Zabbix database schema
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql -uzabbix -pzabbix zabbix

# Configure Zabbix server password
sed -i "s/^# DBPassword=.*/DBPassword=zabbix/" /etc/zabbix/zabbix_server.conf

# Restart and enable services
systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2

echo "Installation complete. Web interface available at http://<server-IP>/zabbix"

