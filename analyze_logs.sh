#!/bin/bash

LOG_FILE="access.log"
REPORT_FILE="report.txt"

# Очищаем предыдущий отчет ТОЛЬКО ОДИН РАЗ в начале
> $REPORT_FILE

echo "Отчет о логе веб-сервера" >> $REPORT_FILE
echo "===========================" >> $REPORT_FILE
echo "" >> $REPORT_FILE

# 1. Общее количество запросов
TOTAL_REQUESTS=$(wc -l < "$LOG_FILE")
echo "Общее количество запросов: $TOTAL_REQUESTS" >> $REPORT_FILE
echo "" >> $REPORT_FILE

# 2. Количество уникальных IP-адресов
echo "Количество уникальных IP-адресов: $(awk '{print $1}' "$LOG_FILE" | sort | uniq | wc -l)" >> $REPORT_FILE
echo "" >> $REPORT_FILE

# 3. Количество запросов по методам
echo "Количество запросов по методам:" >> $REPORT_FILE
awk '{print $6}' "$LOG_FILE" | sed 's/"//g' | sort | uniq -c >> $REPORT_FILE
echo "" >> $REPORT_FILE

# 4. Самый популярный URL
echo "Самый популярный URL: $(awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -1)" >> $REPORT_FILE