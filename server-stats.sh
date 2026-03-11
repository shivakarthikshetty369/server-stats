#!/bin/bash

echo "-------------------------------------------"
echo "        SERVER PERFORMANCE STATS"
echo "-------------------------------------------"
echo ""

# CPU Usage
echo "Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
awk '{print 100 - $1"%"}'

echo ""

# Memory Usage
echo "Memory Usage:"
free -m | awk 'NR==2{
printf "Used: %sMB\nFree: %sMB\nUsage: %.2f%%\n",
$3,$4,$3*100/$2 }'

echo ""

# Disk Usage
echo "Disk Usage:"
df -h / | awk 'NR==2{
printf "Used: %s\nFree: %s\nUsage: %s\n",
$3,$4,$5 }'

echo ""

# Top 5 CPU consuming processes
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

echo ""

# Top 5 Memory consuming processes
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

echo ""
echo "-------------------------------------------"
