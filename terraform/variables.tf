variable "docker_host" {
  description = "Адрес Docker-демона (VM по SSH)"
  type        = string
  default     = "ssh://student@111.88.162.78"
}

variable "ssh_key_path" {
  description = "Приватный SSH-ключ для доступа к VM"
  type        = string
  default     = "~/.ssh/id_ed25519"
}

variable "external_port" {
  description = "Нестандартный внешний порт nginx"
  type        = number
  default     = 8081
}
