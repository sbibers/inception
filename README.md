<h1 align="center">🚀 Inception Project</h1>
<p align="center"><strong>Dockerized Infrastructure - 42 School</strong></p>
<p align="center">
  <img src="https://img.shields.io/badge/Docker-Containerization-blue?logo=docker" />
  <img src="https://img.shields.io/badge/NGINX-HTTPS-green?logo=nginx" />
  <img src="https://img.shields.io/badge/WordPress-CMS-critical?logo=wordpress" />
  <img src="https://img.shields.io/badge/MariaDB-Database-blue?logo=mariadb" />
</p>

---

## 📚 Table of Contents

* [Introduction](#introduction)
* [Project Overview](#project-overview)
* [Features](#-features)
* [Project Structure](#-project-structure)
* [Usage](#usage)
* [Makefile Commands](#makefile-commands)
* [Security Considerations](#security-considerations)
* [Resources](#-additional-resources)
* [Conclusion](#-conclusion)

---

## ✨ Introduction

The Inception project is part of the 42 School curriculum and is designed to enhance your knowledge of system administration using Docker technology. The goal is to virtualize multiple services with Docker containers and Docker Compose, all within a virtual machine.

---

## 🔄 Project Overview

This project involves setting up a small infrastructure composed of the following services:

1. **NGINX**: A web server configured with TLSv1.2 or TLSv1.3.
2. **WordPress**: A CMS running with PHP-FPM.
3. **MariaDB**: A database server for WordPress.
4. **Volumes**:

   * For the WordPress database.
   * For the WordPress files.
5. **Docker Network**: A bridge network connecting all containers.

---

## 🌟 Features

* 🛣️ **Custom Dockerfiles** for each service (NGINX, WordPress, MariaDB)
* 🔐 **TLS Security** with self-signed SSL certificates
* 🌐 **Docker Bridge Network** for container communication
* ⚙️ **Environment Variables** stored securely in `.env`
* ♻️ **Auto-Restart Policy** on failure
* 📋 **Makefile** to manage setup and teardown

---

## 📁 Project Structure

```
.
├── 📄 Makefile
└── 📂 srcs/
    ├── 📄 docker-compose.yml
    ├── 📄 .env
    └── 📂 requirements/
        ├── 📂 mariadb/
        │   ├── 📄 Dockerfile
        │   └── 📂 tools/
        │       ├── 📄 database-config.cnf
        │       ├── 📄 database-script.sh
        │       └── 📄 init.sql.template
        ├── 📂 nginx/
        │   ├── 📄 Dockerfile
        │   └── 📂 tools/
        │       ├── 📄 nginx-config.conf
        │       └── 📄 nginx-script.sh
        └── 📂 wordpress/
            ├── 📄 Dockerfile
            └── 📂 tools/
                ├── 📄 wordpress-script.sh
                └── 📄 www.conf
```

---

## 🚀 Usage

### Prerequisites

* A Linux virtual machine
* Docker and Docker Compose installed

### Setup

```bash
# Clone the repository
git clone https://github.com/sbibers/inception.git
cd inception
```

Create a `.env` file inside the `srcs` directory:

```env
DOMAIN_NAME=your-login.42.fr
WP_DATABASE_NAME=wordpress
WP_DATABASE_HOST=mariadb
DB_ROOT_PASSWORD=root
DB_USER=your_user
DB_USER_PASSWORD=your_password
WP_ADMIN=admin
WP_ADMIN_PASSWORD=admin_password
WP_ADMIN_EMAIL=admin@example.com
WP_USER=user
WP_USER_PASSWORD=user_password
WP_USER_EMAIL=user@example.com
```

Start the project:

```bash
make up
```

Access the services:

* WordPress: [https://localhost](https://localhost)
* Admin Panel: [https://localhost/wp-admin](https://localhost/wp-admin)

### Stop the Project

```bash
make down
```

### Clean Everything

```bash
make clean
```

---

## 📃 Makefile Commands

| Command               | Description                          |
| --------------------- | ------------------------------------ |
| `make up`             | Build and start the containers       |
| `make down`           | Stop containers                      |
| `make restart`        | Restart the project                  |
| `make status`         | Show container status                |
| `make logs`           | View all logs                        |
| `make logs-nginx`     | View NGINX logs                      |
| `make logs-wordpress` | View WordPress logs                  |
| `make logs-mariadb`   | View MariaDB logs                    |
| `make nginx`          | Enter NGINX container                |
| `make wordpress`      | Enter WordPress container            |
| `make mariadb`        | Enter MariaDB container              |
| `make clean`          | Remove containers, volumes, networks |
| `make fclean`         | Clean everything                     |
| `make re`             | Rebuild the project                  |

---

## 🔒 Security Considerations

* Secrets are stored in a `.env` file and not in source code.
* HTTPS is enforced using self-signed certificates.
* Passwords are excluded from version control.

---

## 🔍 Additional Resources

* [Docker Overview](https://www.docker.com/resources/what-container/)
* [Dockerfile Docs](https://docs.docker.com/engine/reference/builder/)
* [Docker Compose File Reference .yaml](https://docs.docker.com/compose/compose-file/)
* [Docker Volumes](https://docs.docker.com/storage/volumes/)
* [Docker Networking](https://docs.docker.com/network/)
* [WordPress](https://wordpress.org/about/)
* [MariaDB](https://mariadb.org/about/)
* [NGINX](https://www.nginx.com/resources/glossary/nginx/)

---

## ✅ Conclusion

This project demonstrates the ability to build a secure and maintainable infrastructure using Docker. By completing it, you gain practical experience with system administration, containerization, and orchestration.

Thanks for reading ✨
