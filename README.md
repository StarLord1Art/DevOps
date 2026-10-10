# Infrastructure & Automation Project

## 1. Настройка удаленной ВМ (Ansible)

```bash
cd ansible

# Отредактируйте inventory.ini (укажите ваш IP ВМ и путь к SSH-ключу)
ansible -i inventory.ini all -m ping
ansible-playbook -i inventory.ini setup_host.yml
```


Скриншот вывода Ansible Playbook (второй запуск, показывающий идемпотентность): 


<img width="1482" height="807" alt="image" src="https://github.com/user-attachments/assets/5d2d2d45-059b-4941-b9a3-e968a3e898c4" />

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


Результат docker-compose ps и curl http://<IP>:


<img width="1206" height="334" alt="image" src="https://github.com/user-attachments/assets/04967bfe-db61-4625-9a40-c2b20ec56a87" />

<img width="734" height="287" alt="image" src="https://github.com/user-attachments/assets/161b80b6-563d-4f43-ad81-d345744c393a" />

## 4. Мониторинг (Bash Script)

```bash
# Копирование скрипта с локальной машины на ВМ
scp -i ~/.ssh/ваш_ключ ../scripts/monitor.sh ubuntu@<IP_АДРЕС_ВМ>:~/

ssh -i ~/.ssh/ваш_ключ ubuntu@<IP_АДРЕС_ВМ>

chmod +x ~/monitor.sh

./monitor.sh docker
```


Результат работы скрипта monitor.sh: 


<img width="1920" height="602" alt="image" src="https://github.com/user-attachments/assets/8ba45ee2-6ee4-4a37-a2ef-60cc79727c7f" />
