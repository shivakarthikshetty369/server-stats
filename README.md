server-stats scrip
==================
where you can find the below mentioned stats of usage

* Total CPU usage
* Total Memory usage (Free vs Used with %)
* Total Disk usage (Free vs Used with %)
* Top 5 processes by CPU usage
* Top 5 processes by Memory usage

---

1. Create the Script


nano server-stats.sh


---

2. Paste This Script


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
```

---

## 3. Give Execute Permission

```bash
chmod +x server-stats.sh
```

---

## 4. Run the Script

```bash
./server-stats.sh
```

---

## 5. Example Output

```
-------------------------------------------
        SERVER PERFORMANCE STATS
-------------------------------------------

Total CPU Usage:
23.5%

Memory Usage:
Used: 2048MB
Free: 1024MB
Usage: 66.67%

Disk Usage:
Used: 15G
Free: 35G
Usage: 30%

Top 5 Processes by CPU Usage:
PID   PPID CMD %MEM %CPU
2341  1    java 12.3 45.2
2212  1    python 5.1 20.3
...

Top 5 Processes by Memory Usage:
PID   PPID CMD %MEM %CPU
2341  1    java 12.3 45.2
...
-------------------------------------------
`````
.....
