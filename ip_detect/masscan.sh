#!/bin/bash
# Description: 采用 ping 方式对 ip.csv 中的 ip 段进行扫描，可以用 crontab 设为定时任务
# Author: AyajiLin
# Date: 2021/12/08
set -e
set -x

CUR_DIR=$(dirname $0)
CUR_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

IP_RANGES=$(cat $CUR_DIR/../data/ip.csv | tr \\n , | sed -r -e "s/,+$//")

# 采用 ping 方式地毯式扫描
sudo masscan $IP_RANGES --ping --rate 1000 -oX "$CUR_DIR/ip_detect_$CUR_DATE.xml"
