---
title: Clash功能-Script脚本
date: 2025-01-22 00:38:00
category_bar: true
tags:
- Clash
- VPN
- 翻墙
- 国际联网
---

# Script 脚本

Clash Premium 实现了基于 Python3 的脚本功能, 使用户能够以动态灵活的方式为数据包选择策略.

您可以使用单个 Python 脚本控制整个规则匹配引擎, 也可以定义一些快捷方式, 并与常规规则一起使用. 本页介绍了第一种功能, 有关后者, 请参见[Script Shortcuts 脚本捷径](https://blog.qingyi-studio.top/2025/01/22/Clash%E5%8A%9F%E8%83%BD-ScriptShortcuts%E8%84%9A%E6%9C%AC%E6%8D%B7%E5%BE%84/).

## 控制整个规则匹配引擎

```yaml
mode: Script

# https://lancellc.gitbook.io/clash/clash-config-file/script
script:
  code: |
    def main(ctx, metadata):
      ip = metadata["dst_ip"] = ctx.resolve_ip(metadata["host"])
      if ip == "":
        return "DIRECT"

      code = ctx.geoip(ip)
      if code == "LAN" or code == "CN":
        return "DIRECT"

      return "Proxy" # default policy for requests which are not matched by any other script
```

如果您想使用 IP 规则 (即: IP-CIDR、GEOIP 等) , 您首先需要手动解析 IP 地址并将其分配给 metadata:

```python
def main(ctx, metadata):
    # ctx.rule_providers["geoip"].match(metadata) return false

    ip = ctx.resolve_ip(metadata["host"])
    if ip == "":
        return "DIRECT"
    metadata["dst_ip"] = ip

    # ctx.rule_providers["iprule"].match(metadata) return true

    return "Proxy"
```

Metadata 和 Context 的接口定义:

```typescript
interface Metadata {
  type: string // socks5、http
  network: string // tcp
  host: string
  src_ip: string
  src_port: string
  dst_ip: string
  dst_port: string
  inbound_port: number
}

interface Context {
  resolve_ip: (host: string) => string // ip string
  resolve_process_name: (metadata: Metadata) => string
  resolve_process_path: (metadata: Metadata) => string
  geoip: (ip: string) => string // country code
  log: (log: string) => void
  proxy_providers: Record<string, Array<{ name: string, alive: boolean, delay: number }>>
  rule_providers: Record<string, { match: (metadata: Metadata) => boolean }>
}
```
