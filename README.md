# Inception Project

## Introduction

The Inception project is part of the 42 School curriculum and is designed to enhance your knowledge of system administration by utilizing Docker technology. The goal is to virtualize multiple services using Docker containers and Docker Compose, all within a virtual machine.

---

## Project Overview

This project involves setting up a small infrastructure composed of the following services:

1. **NGINX**: A web server configured with TLSv1.2 or TLSv1.3.
2. **WordPress**: A content management system running with PHP-FPM.
3. **MariaDB**: A database server for WordPress.
4. **Volumes**:
   - One for the WordPress database.
   - One for the WordPress website files.
5. **Docker Network**: A bridge network to connect all containers.

---

## Features

- **Custom Dockerfiles**: Each service is built from a custom Dockerfile based on Alpine or Debian.
- **Environment Variables**: Sensitive data like credentials are stored in a `.env` file.
- **TLS Security**: NGINX is configured to serve traffic over HTTPS using self-signed certificates.
- **Automatic Restart**: Containers are configured to restart automatically in case of failure.
- **Domain Name**: The project is accessible via a custom domain (`<login>.42.fr`), pointing to the local IP address.

---

## Directory Structure

```
.
├── Makefile
├── srcs/
│   ├── docker-compose.yml
│   ├── .env
│   ├── requirements/
│   │   ├── mariadb/
│   │   │   ├── Dockerfile
│   │   │   ├── tools/
│   │   │       ├── database-config.cnf
│   │   │       ├── database-script.sh
│   │   │       └── init.sql.template
│   │   ├── nginx/
│   │   │   ├── Dockerfile
│   │   │   ├── tools/
│   │   │       ├── nginx-config.conf
│   │   │       └── nginx-script.sh
│   │   ├── wordpress/
│   │       ├── Dockerfile
│   │       ├── tools/
│   │           ├── wordpress-script.sh
│   │           └── www.conf
```

---

## Usage

### Prerequisites

- A virtual machine running Linux.
- Docker and Docker Compose installed.

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/sbibers/inception.git
   cd inception
   ```

2. Create a `.env` file in the `srcs` directory with the following variables:
   ```env
   DOMAIN_NAME=<your-login>.42.fr
   WP_DATABASE_NAME=wordpress
   DB_USER=<db-user>
   DB_USER_PASSWORD=<db-password>
   WP_ADMIN=<admin-username>
   WP_ADMIN_PASSWORD=<admin-password>
   WP_ADMIN_EMAIL=<admin-email>
   WP_USER=<user-username>
   WP_USER_PASSWORD=<user-password>
   WP_USER_EMAIL=<user-email>
   ```

3. Start the project using the Makefile:
   ```bash
   make up
   ```

4. Access the services:
   - WordPress: `https://localhost`
   - Admin Panel: `https://localhost/wp-admin`

### Stopping the Project

To stop all containers:
```bash
make down
```

### Cleaning Up

To remove all containers, volumes, and networks:
```bash
make clean
```

---

## Makefile Commands

- `make up`: Build and start the project.
- `make down`: Stop all containers.
- `make restart`: Restart the project.
- `make status`: Show the status of containers, networks, and volumes.
- `make logs`: View logs for all services.
- `make logs-nginx`: View logs for the NGINX container.
- `make logs-wordpress`: View logs for the WordPress container.
- `make logs-mariadb`: View logs for the MariaDB container.
- `make nginx`: Access the NGINX container.
- `make wordpress`: Access the WordPress container.
- `make mariadb`: Access the MariaDB container.
- `make clean`: Clean project data.
- `make fclean`: Clean everything.
- `make re`: Clean everything and rebuild the project.

---

## Security Considerations

- Sensitive data is stored in the `.env` file and not hardcoded in Dockerfiles.
- Self-signed certificates are used for HTTPS.
- Passwords and credentials are not committed to version control.

---

## Additional Resources

To better understand the technologies used in this project, refer to the following resources:

- [What is Docker?](https://www.docker.com/resources/what-container/)
- [What is a Dockerfile?](https://docs.docker.com/engine/reference/builder/)
- [What is a Docker Container?](https://www.docker.com/resources/what-container/)
- [What is a Docker Volume?](https://docs.docker.com/storage/volumes/)
- [What is a Docker Network?](https://docs.docker.com/network/)
- [What is WordPress?](https://wordpress.org/about/)
- [What is MariaDB?](https://mariadb.org/about/)
- [What is NGINX?](https://www.nginx.com/resources/glossary/nginx/)

---

## How to Build the Project

### Prerequisites

Ensure you have the following installed on your system:

1. A Linux-based operating system.
2. Docker and Docker Compose.

### Steps to Build the Project

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd inception
   ```

2. **Set Up Environment Variables**:
   Create a `.env` file in the `srcs` directory with the following content:
   ```env
   DOMAIN_NAME=<your-login>.42.fr
   WP_DATABASE_NAME=wordpress
   WP_DATABASE_HOST=mariadb
   DB_ROOT_PASSWORD=root 
   DB_USER=<db-user>
   DB_USER_PASSWORD=<db-password>
   WP_ADMIN=<admin-username>
   WP_ADMIN_PASSWORD=<admin-password>
   WP_ADMIN_EMAIL=<admin-email>
   WP_USER=<user-username>
   WP_USER_PASSWORD=<user-password>
   WP_USER_EMAIL=<user-email>
   ```

3. **Build and Start the Project**:
   Use the Makefile to build and start the project:
   ```bash
   make up
   ```

4. **Access the Services**:
   - WordPress: `https://localhost`
   - Admin Panel: `https://localhost/wp-admin`

### Stopping the Project

To stop all running containers:
```bash
make down
```

### Cleaning Up

To remove all containers, volumes, and networks:
```bash
make clean
```

---

## Conclusion

This project demonstrates the ability to set up a secure and scalable infrastructure using Docker. By completing this project, you will gain hands-on experience with containerization, networking, and system administration.