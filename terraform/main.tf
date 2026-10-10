terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "docker" {}

resource "local_file" "nginx_index" {
  content  = "200 OK\nHello from Terraform-managed Nginx!\n"
  filename = "${path.module}/index.html"
}

resource "docker_network" "custom_net" {
  name = "terraform_nginx_network"
}

resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = false
}

resource "docker_container" "nginx" {
  name  = "terraform_nginx_app"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8081
  }

  networks_advanced {
    name = docker_network.custom_net.name
  }

  mounts {
    target    = "/usr/share/nginx/html/index.html"
    source    = local_file.nginx_index.filename
    type      = "bind"
    read_only = true
  }

  restart = "always"
}

output "curl_command" {
  description = "Команда для проверки работы Nginx"
  value       = "curl -i http://localhost:8081"
}

output "network_name" {
  description = "Имя созданной сети"
  value       = docker_network.custom_net.name
}
