---
title: Modify the default intra-site DC replication interval
description: Describes how to modify the default intra-site domain controller replication interval.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Active Directory replication
ms.technology: windows-server-active-directory
---
# How to Modify the Default Intra-Site Domain Controller Replication Interval

This article describes how to modify the default intra-site domain controller replication interval.

_Original product version:_ &nbsp;Windows Server 2012 R2  
_Original KB number:_ &nbsp;214678

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, click the following article number to view the article in the Microsoft Knowledge Base:
[256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows Registry  

## More information

When a domain controller writes a change to its local copy of the Active Directory, a timer is started that determines when the domain controller's replication partners should be notified of the change. By default, this interval is 15 seconds in Windows Server 2003 and later; it was 300 seconds (5 minutes) in Windows 2000. When this interval elapses, the domain controller initiates a notification to each intra-site replication partner that it has changes that need to be propagated. Another configurable parameter determines the number of seconds to pause between notification. This parameter prevents simultaneous replies by the replication partners. By default, this interval is 30 seconds. Both of these intervals can be modified by editing the registry.

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.  

To change the delay between the change to the Active Directory and first replication partner notification, use Registry Editor to change the value data for the "Replicator notify pause after modify (secs)" DWORD value in the following registry key:

Path: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`  
Key: Replicator notify pause after modify (secs)  
Value: REG_DWORD  

The default value data for the "Replicator notify pause after modify (secs)" DWORD value in Windows 2000 is 0x12c. This hexadecimal format is equal to a decimal value of 300 that is equal to 5 minutes. In Windows Server 2003 and in later versions, the default value data is 15 seconds.

To change the notification delay between domain controllers, use Registry Editor to change the value data for the "Replicator notify pause between DSAs (secs)" DWORD value in the following registry key:  

Path: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`  
Key: Replicator notify pause between DSAs (secs)  
Value: REG_DWORD  

The default value data for the "Replicator notify pause between DSAs (secs)" DWORD value in Windows 2000 is 0x1e. This hexadecimal format is equal to a decimal value of 30 that is equal to 30 seconds. The default value in Windows Server 2003 and in later versions is decreased to 3 seconds when the forest functional level is Windows Server 2003 or a higher functional level.

> [!NOTE]
> A setting also applies to Active Directory Application Mode (ADAM) and Active Directory Lightweight Directory Services (AD LDS). For ADAM and for AD LDS, the registry key is in the ADAM instance "Parameters" registry key.
