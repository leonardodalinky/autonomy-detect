#!/bin/bash
# Author: AyajiLin
# Date: 2021/12/08
set -e
set -x

CUR_DIR=$(dirname $0)
CUR_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

IP_RANGES=$(cat $CUR_DIR/../data/ip.csv | tr \\n , | sed -r -e "s/,+$//")
PORT_RANGES=$(cat $CUR_DIR/../data/port.csv | tr \\n , | sed -r -e "s/,+$//")

# 扫描端口列表中的端口
sudo masscan -p$PORT_RANGES $IP_RANGES -oX "port_detect_$CUR_DATE.xml"
