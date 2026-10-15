# Infrastructure & Automation Project

## Создание SSH-ключа и копирование на VM

```bash
ssh-keygen -t ed25519 -f ~/.ssh/your_path

ssh-copy-id -i ~/.ssh/your_path.pub student@<VM_IP>
```

## 1. Ansible

```bash
cd ansible

# Отредактируйте inventory.ini (укажите ваш IP ВМ и путь к SSH-ключу)
ansible -i inventory.ini all -m ping

ansible-playbook -i inventory.ini setup_host.yml
```


Скриншот вывода Ansible Playbook (второй запуск, показывающий идемпотентность):

<img width="1482" height="807" alt="image" src="https://github.com/user-attachments/assets/5d2d2d45-059b-4941-b9a3-e968a3e898c4" />

## 2. Terraform

```bash
cd terraform

terraform init

terraform apply

curl -i http://<VM_IP>:8081

terraform state list
```

## 3. Docker Compose

```bash
ssh -i ~/.ssh/ваш_ключ student@<VM_IP>

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
scp -i ~/.ssh/ваш_ключ ./scripts/monitor.sh student@<VM_IP>:~/

ssh -i ~/.ssh/ваш_ключ student@<VM_IP>

chmod +x ~/monitor.sh

./monitor.sh docker
```


Результат работы скрипта monitor.sh:

<img width="1920" height="602" alt="image" src="https://github.com/user-attachments/assets/8ba45ee2-6ee4-4a37-a2ef-60cc79727c7f" />
