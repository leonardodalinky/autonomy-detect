# Description: 用于解析 ip_detect 中的 xml
# Author: AyajiLin
# Date: 2021/12/08
import os
import sys
import ipaddress
from datetime import datetime, timezone
from dataclasses import dataclass, field
from xml.dom import minidom
from typing import List

sys.path.append(os.path.realpath(f"{os.path.dirname(__file__)}/.."))


@dataclass
class Host:
    # 带 tzinfo 的时间
    end_time: datetime
    # ipv4
    ip: ipaddress.IPv4Address


@dataclass
class IpDetect:
    # 带 tzinfo 的时间
    start_time: datetime
    hosts: List[Host] = field(default_factory=list)


def parse_xml(filepath: str) -> IpDetect:
    dom: minidom.Document = minidom.parse(filepath)
    # 起始时间
    nmaprun_ele: minidom.Element = dom.getElementsByTagName("nmaprun")[0]
    ret = IpDetect(datetime.fromtimestamp(int(nmaprun_ele.getAttribute("start"))).astimezone(timezone.utc))
    # 每个 ip
    for host_ele in dom.getElementsByTagName("host"):
        host_ele: minidom.Element
        address_ele: minidom.Element = host_ele.getElementsByTagName("address")[0]
        ret.hosts.append(Host(
            end_time=datetime.fromtimestamp(int(host_ele.getAttribute("endtime"))).astimezone(timezone.utc),
            ip=ipaddress.ip_address(address_ele.getAttribute("addr")),
        ))
    
    return ret
