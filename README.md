# Infrastructure & Automation Project

---

## 1. Настройка удаленной ВМ (Ansible)

```bash
cd ansible

# Отредактируйте inventory.ini (укажите ваш IP ВМ и путь к SSH-ключу)
ansible -i inventory.ini all -m ping
ansible-playbook -i inventory.ini setup_host.yml
```

## 2. Локальное окружение (Terraform + Docker)

```bash
cd terraform

# Убедитесь, что Docker запущен

terraform init
terraform apply

# Проверка (должен вернуть 200 OK и текст)
curl -i http://localhost:8081

terraform destroy
```

## 3. Развертывание приложения на ВМ (Docker Compose)

```bash
ssh -i ~/.ssh/ваш_ключ ubuntu@<IP_АДРЕС_ВМ>

cd /opt/app

docker compose up -d

curl http://localhost
```

## 4. Мониторинг (Bash Script)

```bash
# Копирование скрипта с локальной машины на ВМ
scp -i ~/.ssh/ваш_ключ ../scripts/monitor.sh ubuntu@<IP_АДРЕС_ВМ>:~/

ssh -i ~/.ssh/ваш_ключ ubuntu@<IP_АДРЕС_ВМ>

chmod +x ~/monitor.sh

./monitor.sh docker
```
