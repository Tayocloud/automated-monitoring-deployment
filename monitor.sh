#!/bin/bash

# Thresholds
CPU_THRESHOLD=80
DISK_THRESHOLD=80
MEM_THRESHOLD=80

# Email settings
TO_EMAIL="switayo28@gmail.com"
SUBJECT="EC2 ALERT: Resource Usage Exceeded Thresholds"
TMPFILE="/tmp/monitor_alert.txt"

# Log file
LOG_FILE="$HOME/ec2_monitor.log"

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Redirect all output to log
exec >> "$LOG_FILE" 2>&1

log "Starting EC2 monitoring check."

# Get usage data
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
MEM_USAGE=$(free | awk '/Mem:/ {printf "%.2f", $3/$2 * 100.0}')

log "CPU Usage: $CPU_USAGE%"
log "Disk Usage: $DISK_USAGE%"
log "Memory Usage: $MEM_USAGE%"

echo "CPU: $CPU_USAGE%, Disk: $DISK_USAGE%, Memory: $MEM_USAGE%" > $TMPFILE

ALERT=false

if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    log "ALERT: High CPU usage detected: $CPU_USAGE%"
    echo "High CPU Usage: $CPU_USAGE%" >> $TMPFILE
    ALERT=true
fi

if (( $(echo "$DISK_USAGE > $DISK_THRESHOLD" | bc -l) )); then
    log "ALERT: High Disk usage detected: $DISK_USAGE%"
    echo "High Disk Usage: $DISK_USAGE%" >> $TMPFILE
    ALERT=true
fi

if (( $(echo "$MEM_USAGE > $MEM_THRESHOLD" | bc -l) )); then
    log "ALERT: High Memory usage detected: $MEM_USAGE%"
    echo "High Memory Usage: $MEM_USAGE%" >> $TMPFILE
    ALERT=true
fi

if [ "$ALERT" = true ]; then
    log "Sending alert email to $TO_EMAIL"
    mail -s "$SUBJECT" "$TO_EMAIL" < $TMPFILE
else
    log "No thresholds exceeded. No alert sent."
fi

log "Monitoring check completed."
