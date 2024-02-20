---
title: Modify the default intra-site DC replication interval
description: Describes how to modify the default intra-site domain controller replication interval.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# How to Modify the Default Intra-Site Domain Controller Replication Interval

This article describes how to modify the default intra-site domain controller replication interval.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 214678

## More information

When a domain controller writes a change to its local copy of the Active Directory, a timer is started that determines when the domain controller's replication partners should be notified of the change. By default, this interval is 15 seconds in Windows Server 2003 and later versions. When this interval elapses, the domain controller initiates a notification to each intra-site replication partner that it has changes that need to be propagated. Another configurable parameter determines the number of seconds to pause between notification. This parameter prevents simultaneous replies by the replication partners. By default, this interval is 3 seconds in Windows Server 2003 and later versions, when the forest functional level is Windows Server 2003 or a higher functional level. Both of these intervals can be modified by editing the registry.

> [!WARNING]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](../performance/windows-registry-advanced-users.md).

To change the delay between the change to the Active Directory and first replication partner notification, use Registry Editor to change the value data for the "Replicator notify pause after modify (secs)" DWORD value in the following registry key:

Path: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`  
Key: Replicator notify pause after modify (secs)  
Value: REG_DWORD  

To change the notification delay between domain controllers, use Registry Editor to change the value data for the "Replicator notify pause between DSAs (secs)" DWORD value in the following registry key:  

Path: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`  
Key: Replicator notify pause between DSAs (secs)  
Value: REG_DWORD  

> [!NOTE]
> A setting also applies to Active Directory Application Mode (ADAM) and Active Directory Lightweight Directory Services (AD LDS). For ADAM and for AD LDS, the registry key is in the ADAM instance "Parameters" registry key.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
