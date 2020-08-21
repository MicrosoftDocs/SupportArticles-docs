---
title: DNS Servers fail to resolve queries
description: Provides a solution to an issue where DNS Servers fail to resolve queries for names in certain top-level domains.
ms.date: 08/18/2020
author: delhan
ms.author: Deland-Han
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: DNS
ms.technology: Networking
---
# DNS Servers may fail to resolve queries for some top-level domains

This article provides a solution to an issue where DNS Servers fail to resolve queries for names in certain top-level domains.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 968372

## Symptom

When name resolution is provided by root hints, Windows Server 2008 DNS and Windows Server 2008 R2 DNS Servers may fail to resolve queries for names in certain top-level domains. When this happens, the problem will continue until the DNS Server cache is cleared or the DNS Server service is restarted. The problem can be seen with domains like .co.uk, .cn, .biz, and .br, but isn't limited to these domains.

When the problem is happening, a nslookup command issued for an affected name will return the error **server failed**. A network trace will show that the DNS server doesn't send any traffic for such a request to the Internet. No events related to a problem are reported in the DNS Event Log.

This problem doesn't happen if DNS Server is configured to use forwarders for Internet name resolution instead of root hints.

## Resolution

To resolve the issue and continue using root hints, change the **MaxCacheTTL** registry value to two days or greater.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or another method. These problems might require you to reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Start Registry Editor (regedit.exe).

2. Locate the following registry key:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters`

3. On the **Edit** menu, click **New**, click **DWORD (32-bit) Value**, and then add the following value:

    - Value: MaxCacheTTL
    - Data Type: DWORD
    - Data value: 0x2A300 (172,800 seconds in decimal, or two days)

4. Click OK.

5. Quit Registry Editor.

6. Restart the DNS Server service.

> [!NOTE]
> The .biz top level has a TTL of six days for its NS and A records. Thus, you may need to set the **MaxCacheTTL** to **518400** for six days or even **604800** for seven days.
