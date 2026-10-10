#!/bin/bash

SERVICE_NAME=$1

if [ -z "$SERVICE_NAME" ]; then
    echo "Использование: $0 <service_name>"
    exit 1
fi

echo "Проверка сервиса: $SERVICE_NAME"

if systemctl is-active --quiet "$SERVICE_NAME"; then
    echo "Сервис работает"
else
    echo "Сервис НЕ работает"
    echo ""
    echo "Последние логи:"
    journalctl -u "$SERVICE_NAME" -n 10 --no-pager
fi

echo ""
echo "Ошибки в syslog за последний час:"

CURRENT_HOUR=$(date '+%H')
PREV_HOUR=$(date -d '1 hour ago' '+%H' 2>/dev/null || date -v-1H '+%H' 2>/dev/null)

grep -E "$(date '+%b.*%e') ($CURRENT_HOUR|$PREV_HOUR):" /var/log/syslog 2>/dev/null | \
    grep -i "error\|fail\|critical" | \
    wc -l | \
    awk '{print "Количество ошибок: " $1}'
