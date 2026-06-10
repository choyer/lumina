# Ansible Configuration Management

Available playbooks:

| file | Description |
| ---- | ----------- |
| [dev_install_rust_toolchain.yml](dev_install_rust_toolchain.yml) | Installs the rust toolchain (development machine) |
| [dev_get_httpd2.yml](/ansible/dev_get_httpd2.yml) | Fetches (clone/pull) httpd2 via git from official respository |
| [httpd2_create_webroot.yml](/ansible/httpd2_create_webroot.yml) | Prompts & creates path for webroot files |

Note: these playbooks are aimed for use on a A20-OLinuXino-LIME2 running Armbian
