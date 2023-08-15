#!/bin/bash

# 定义变量
cron_file="/var/spool/cron/crontabs/root"
binlog_job="*/30 * * * * binlog_backup.sh"
full_job="0 3 * * * mysql_backup.sh"

# 添加定时任务
echo "binlog_job" >> $cron_file
echo "full_job" >> $cron_file