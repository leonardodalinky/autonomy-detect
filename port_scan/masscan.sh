#!/bin/bash
# Description: 使用 SYN 包对 ip.csv 以及 port.csv 中的地址和端口进行端口探测，发包速率太高会炸裂，慎调！
# Author: AyajiLin
# Date: 2021/12/08
set -e
set -x

CUR_DIR=$(dirname $0)
CUR_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

IP_RANGES=$(cat $CUR_DIR/../data/ip.csv | tr \\n , | sed -r -e "s/,+$//")
PORT_RANGES=$(cat $CUR_DIR/../data/port.csv | tr \\n , | sed -r -e "s/,+$//")

# 扫描端口列表中的端口
sudo masscan -p$PORT_RANGES $IP_RANGES --rate 2000 -oX "$CUR_DIR/port_detect_$CUR_DATE.xml"
