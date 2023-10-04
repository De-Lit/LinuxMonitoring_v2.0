#!/bin/sh

# RAM
echo "# HELP node_memory_MemTotal_bytes Memory information field MemTotal_bytes."
echo "# TYPE node_memory_MemTotal_bytes gauge"
MEM_TOTAL="$(grep -i -e 'MemTotal' /proc/meminfo | awk '{printf "%e", $2 * 1024}')"
[ -n "$MEM_TOTAL" ] && echo "node_memory_MemTotal_bytes $MEM_TOTAL"

echo "# HELP node_memory_MemAvailable_bytes Memory information field MemAvailable_bytes."
echo "# TYPE node_memory_MemAvailable_bytes gauge"
MEM_AVAILABLE="$(grep -i -e 'MemAvailable' /proc/meminfo | awk '{printf "%e", $2 * 1024}')"
[ -n "$MEM_AVAILABLE" ] && echo "node_memory_MemAvailable_bytes $MEM_AVAILABLE"

echo "# HELP node_memory_Buffers_bytes Memory information field Buffers_bytes."
echo "# TYPE node_memory_Buffers_bytes gauge"
MEM_BUFFER="$(grep -i -e 'Buffers' /proc/meminfo | awk '{printf "%e", $2 * 1024}')"
[ -n "$MEM_BUFFER" ] && echo "node_memory_Buffers_bytes $MEM_BUFFER"

echo "# HELP node_memory_Cached_bytes Memory information field Cached_bytes."
echo "# TYPE node_memory_Cached_bytes gauge"
MEM_CACHED="$(grep -i -e '^Cached' /proc/meminfo | awk '{printf "%e", $2 * 1024}')"
[ -n "$MEM_CACHED" ] && echo "node_memory_Cached_bytes $MEM_CACHED"

echo "# HELP node_memory_Slab_bytes Memory information field Slab_bytes."
echo "# TYPE node_memory_Slab_bytes gauge"
MEM_SLAB="$(grep -i -e 'Slab' /proc/meminfo | awk '{printf "%e", $2 * 1024}')"
[ -n "$MEM_SLAB" ] && echo "node_memory_Slab_bytes $MEM_SLAB"

echo "# HELP node_memory_PageTables_bytes Memory information field PageTables_bytes."
echo "# TYPE node_memory_PageTables_bytes gauge"
MEM_PAGE_TABLES="$(grep -i -e 'PageTables' /proc/meminfo | awk '{printf "%e", $2 * 1024}')"
[ -n "$MEM_PAGE_TABLES" ] && echo "node_memory_PageTables_bytes $MEM_PAGE_TABLES"

echo "# HELP node_memory_SwapCached_bytes Memory information field SwapCached_bytes."
echo "# TYPE node_memory_SwapCached_bytes gauge"
MEM_CACHED="$(grep -i -e 'SwapCached' /proc/meminfo | awk '{printf "%e", $2 * 1024}')"
[ -n "$MEM_CACHED" ] && echo "node_memory_SwapCached_bytes $MEM_CACHED"

echo "# HELP node_memory_MemFree_bytes Memory information field MemFree_bytes."
echo "# TYPE node_memory_MemFree_bytes gauge"
MEM_FREE="$(grep -i -e 'MemFree' /proc/meminfo | awk '{printf "%e", $2 * 1024}')"
[ -n "$MEM_FREE" ] && echo "node_memory_MemFree_bytes $MEM_FREE"

# Disk Memory
MOUNNTPOINT='/'
DEVICE="$(df -Th | grep -i -e "$MOUNNTPOINT$" | awk '{printf "%s", $1}')"
FSTYPE="$(df -Th | grep -i -e "$MOUNNTPOINT$" | awk '{printf "%s", $2}')"

echo "# HELP node_filesystem_size_bytes Filesystem size in bytes."
echo "# TYPE node_filesystem_size_bytes gauge"
VALUE="$(df -B1 | grep -i -e "$DEVICE" | awk '{printf "%e", $2}')"
[ -n "$VALUE" ] && echo "node_filesystem_size_bytes{device=\"$DEVICE\",fstype=\"$FSTYPE\",mountpoint=\"$MOUNNTPOINT\"} $VALUE"

echo "# HELP node_filesystem_avail_bytes Filesystem space available to non-root users in bytes."
echo "# TYPE node_filesystem_avail_bytes gauge"
VALUE="$(df -B1 | grep -i -e "$DEVICE" | awk '{printf "%e", $4}')"
[ -n "$VALUE" ] && echo "node_filesystem_avail_bytes{device=\"$DEVICE\",fstype=\"$FSTYPE\",mountpoint=\"$MOUNNTPOINT\"} $VALUE"

#CPU
echo "# HELP node_cpu_seconds_total Seconds the CPUs spent in each mode."
echo "# TYPE node_cpu_seconds_total counter"

CPU_NUM=0;
while
    [[ -n "$(grep "cpu$CPU_NUM" /proc/stat)" ]]
do
VALUE="$(grep "cpu$CPU_NUM" /proc/stat | awk '{printf "%.2f", $5 / 100}')"
MODE="idle"
[ -n "$VALUE" ] && echo "node_cpu_seconds_total{cpu=\"$CPU_NUM\",mode=\"$MODE\"} $VALUE"
VALUE="$(grep "cpu$CPU_NUM" /proc/stat | awk '{printf "%.2f", $6 / 100}')"
MODE="iowait"
[ -n "$VALUE" ] && echo "node_cpu_seconds_total{cpu=\"$CPU_NUM\",mode=\"$MODE\"} $VALUE"
VALUE="$(grep "cpu$CPU_NUM" /proc/stat | awk '{printf "%.2f", $7 / 100}')"
MODE="irq"
[ -n "$VALUE" ] && echo "node_cpu_seconds_total{cpu=\"$CPU_NUM\",mode=\"$MODE\"} $VALUE"
VALUE="$(grep "cpu$CPU_NUM" /proc/stat | awk '{printf "%.2f", $3 / 100}')"
MODE="nice"
[ -n "$VALUE" ] && echo "node_cpu_seconds_total{cpu=\"$CPU_NUM\",mode=\"$MODE\"} $VALUE"
VALUE="$(grep "cpu$CPU_NUM" /proc/stat | awk '{printf "%.2f", $8 / 100}')"
MODE="softirq"
[ -n "$VALUE" ] && echo "node_cpu_seconds_total{cpu=\"$CPU_NUM\",mode=\"$MODE\"} $VALUE"
VALUE="$(grep "cpu$CPU_NUM" /proc/stat | awk '{printf "%.2f", $9 / 100}')"
MODE="steal"
[ -n "$VALUE" ] && echo "node_cpu_seconds_total{cpu=\"$CPU_NUM\",mode=\"$MODE\"} $VALUE"
VALUE="$(grep "cpu$CPU_NUM" /proc/stat | awk '{printf "%.2f", $4 / 100}')"
MODE="system"
[ -n "$VALUE" ] && echo "node_cpu_seconds_total{cpu=\"$CPU_NUM\",mode=\"$MODE\"} $VALUE"
VALUE="$(grep "cpu$CPU_NUM" /proc/stat | awk '{printf "%.2f", $2 / 100}')"
MODE="user"
[ -n "$VALUE" ] && echo "node_cpu_seconds_total{cpu=\"$CPU_NUM\",mode=\"$MODE\"} $VALUE"

let "CPU_NUM++"
done
