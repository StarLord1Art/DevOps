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

provider "docker" {
  host     = var.docker_host
  ssh_opts = ["-i", pathexpand(var.ssh_key_path), "-o", "StrictHostKeyChecking=accept-new"]
}

resource "local_file" "nginx_index" {
  content  = "Hello from Terraform-managed Nginx on Remote VM!\n"
  filename = "${path.module}/index.html"
}

resource "docker_network" "web" {
  name = "tf-web-net"
}

resource "docker_image" "nginx" {
  name         = "nginx:1.27-alpine"
  keep_locally = false
}

resource "docker_container" "nginx" {
  name  = "tf-nginx"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = docker_network.web.name
  }

  mounts {
    target    = "/usr/share/nginx/html/index.html"
    source    = local_file.nginx_index.filename
    type      = "bind"
    read_only = true
  }

  ports {
    internal = 80
    external = var.external_port
  }
}
