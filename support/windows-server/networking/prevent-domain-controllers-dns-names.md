---
title: Prevent domain controllers from dynamically registering DNS names
description: Describes how to prevent domain controllers from dynamically registering DNS names.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
---
# How to prevent domain controllers from dynamically registering DNS names

This article describes how to prevent domain controllers from dynamically registering DNS names.

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, see [Windows registry information for advanced users](https://support.microsoft.com/help/256986)

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 198767

## Summary

By default, the Netlogon service on a domain controller registers dynamic Domain Name Service (DNS) records to advertise Active Directory directory services. This behavior can be disabled with a registry setting.

## More information

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.  

The Netlogon service registers these records when a domain controller is restarted, when the Netlogon service is restarted, and once each hour to ensure the records are registered correctly. Some DNS servers that don't support dynamic updating (RFC 2136) may generate errors. If all DNS entries are entered manually and dynamic DNS isn't used, the following registry setting prevents the Netlogon service from registering the Active Directory directory service DNS records:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\UseDynamicDns`

The default value data for the UseDynamicDns REG_DWORD value is 0x1. Changing the UseDynamicDns REG_DWORD value to 0x0 disables dynamic registration and the records specified in %windir%\\system32\\config\\netlogon.dns folder must be manually registered.
