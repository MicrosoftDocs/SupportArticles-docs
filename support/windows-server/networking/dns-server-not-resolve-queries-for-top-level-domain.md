---
title: Windows Server 2008 and Windows Server 2008 R2 DNS Servers may fail to resolve queries for some top-level domains
description: 
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Windows Server 2008 and Windows Server 2008 R2 DNS Servers may fail to resolve queries for some top-level domains

Source: Microsoft Support

_Original product version:_ &nbsp; Windows Server 2008 Datacenter without Hyper-V, Windows Server 2008 Enterprise without Hyper-V, Windows Server 2008 Standard without Hyper-V, Windows Server 2008 Datacenter, Windows Server 2008 Enterprise, Windows Server 2008 Standard, Windows Small Business Server 2008 Premium, Windows Small Business Server 2008 Standard, Windows Server 2008 R2 Standard, Windows Small Business Server 2011 Essentials, Windows Small Business Server 2011 Standard, Windows Small Business Server 2011 Premium Add-On  
_Original KB number:_ &nbsp; 968372

## RAPID PUBLISHING

RAPID PUBLISHING ARTICLES PROVIDE INFORMATION DIRECTLY FROM WITHIN THE MICROSOFT SUPPORT ORGANIZATION. THE INFORMATION CONTAINED HEREIN IS CREATED IN RESPONSE TO EMERGING OR UNIQUE TOPICS, OR IS INTENDED SUPPLEMENT OTHER KNOWLEDGE BASE INFORMATION.

## Symptom

When name resolution is provided by root hints, Windows Server 2008 DNS and Windows Server 2008 R2 DNS Servers may fail to resolve queries for names in certain top-level domains. When this happens, the problem will continue until the DNS Server cache is cleared or the DNS Server service is restarted. The problem can be seen with domains like .co.uk, .cn, .biz, and .br, but is not limited to these domains. 

When the problem is happening, an nslookup command issued for an affected name will return the error "server failed". A network trace will show that the DNS server does not send any traffic for such a request to the Internet. No events related to a problem are reported in the DNS Event Log.

This problem does not happen if DNS Server is configured to use forwarders for Internet name resolution instead of root hints.

## Resolution

To resolve the issue and continue using root hints, change the MaxCacheTTL registry value to 2 days or greater.

Warning: Serious problems might occur if you modify the registry incorrectly by using Registry Editor or another method. These problems might require you to reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Start Registry Editor (regedit.exe).

2. Locate the following registry key:

3. HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters

4. On the Edit menu, click New, click DWORD (32-bit) Value, and then add the following value:

- Value: MaxCacheTTL
- Data Type: DWORD
- Data value: 0x2A300 (172800 seconds in decimal, or 2 days)

5. Click OK.

6. Quit Registry Editor.

7. Restart the DNS Server service.

Note: The .biz top level has a TTL of 6 days for its NS and A records. Thus, you may need to set the MaxCacheTTL to 518400 for 6 days or even 604800 for 7 days.

## DISCLAIMER

MICROSOFT AND/OR ITS SUPPLIERS MAKE NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY, RELIABILITY OR ACCURACY OF THE INFORMATION CONTAINED IN THE DOCUMENTS AND RELATED GRAPHICS PUBLISHED ON THIS WEBSITE (THE "MATERIALS") FOR ANY PURPOSE. THE MATERIALS MAY INCLUDE TECHNICAL INACCURACIES OR TYPOGRAPHICAL ERRORS AND MAY BE REVISED AT ANY TIME WITHOUT NOTICE.

TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, MICROSOFT AND/OR ITS SUPPLIERS DISCLAIM AND EXCLUDE ALL REPRESENTATIONS, WARRANTIES, AND CONDITIONS WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING BUT NOT LIMITED TO REPRESENTATIONS, WARRANTIES, OR CONDITIONS OF TITLE, NON INFRINGEMENT, SATISFACTORY CONDITION OR QUALITY, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, WITH RESPECT TO THE MATERIALS.
