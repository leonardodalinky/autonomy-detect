#!/bin/bash
# Author: AyajiLin
# Date: 2021/12/08
set -e
set -x

CUR_DIR=$(dirname $0)
CUR_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

IP_RANGES=$(cat $CUR_DIR/../data/ip.csv | tr \\n , | sed -r -e "s/,+$//")

# 采用 ping 方式地毯式扫描
sudo masscan $IP_RANGES --ping -oX "ip_detect_$CUR_DATE.xml"
