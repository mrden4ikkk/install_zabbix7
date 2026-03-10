# Zabbix 7.0 Installation Script for Ubuntu 24.04

This repository contains a Bash script that automates the installation of **Zabbix 7.0 LTS** with **MySQL** on Ubuntu 24.04.  
The script sets up the database, imports the schema, configures the Zabbix server, and enables the web interface via Apache.
---
## Features
- Installs and configures **MySQL server**.
- Creates a dedicated **Zabbix database** and user.
- Adds the official **Zabbix 7.0 repository**.
- Installs **Zabbix server, agent, frontend (PHP + Apache)**.
- Imports the initial database schema.
- Configures Zabbix server to use the created database.
- Enables and starts all required services.
---
## Requirements
- Ubuntu 24.04 (fresh installation recommended).
- Root or sudo privileges.
- Internet connection (to download packages and repository).
---
## Usage
1. Download the script:
   ```bash
   wget https://example.com/install_zabbix7.sh
   chmod +x install_zabbix7.sh
   ```
2. Run the script as root:
   ```bash
   sudo ./install_zabbix7.sh
   ```
3. After installation, access the Zabbix web interface:
   ```
   http://<server-ip>/zabbix
   ```
---
## Default Settings
- Database name: `zabbix`
- Database user: `zabbix`
- Database password: `zabbix`
- Root password: set during MySQL installation
- Web interface: Apache on port 80, path `/zabbix`
---
## Notes
- If you want to change the Apache port (e.g., to 8080), edit `/etc/apache2/ports.conf` and the virtual host configuration.
- For production environments, update the database password and configure SSL for Apache.
- After installation, complete the setup wizard in the Zabbix web interface.
---
**Result:** A fully functional Zabbix 7.0 monitoring system with MySQL backend and web interface, ready to use.
---
