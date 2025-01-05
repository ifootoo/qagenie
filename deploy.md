# Docker Deployment Guide for Ubuntu

## Prerequisites
1. Update package list:

```bash
sudo apt update
```

2. Install Docker:

```bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

3. Verify Docker installation:

```bash
sudo systemctl status docker
```

## Deployment

```bash
cd qagenie
sudo docker compose up -d
```

## Initialize Data

```bash
sh setup.sh
```

Default account information:

```
hello@ifootoo.com / admin  /  QA123456
```
you can modify the account information in the `setup.sh` file.

# How to use
Use your browser to visit http://localhost to start using.