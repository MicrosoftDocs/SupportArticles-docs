---
title: (Faulted Not Found) status for NIC team after you restart Windows from an iSCSI boot disk
description: Describes an issue that occurs if Windows Server 2012 is configured to start from an iSCSI disk
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, steved
ms.custom: sap:windows-nic-teaming-load-balance-failover, csstroubleshoot
---
# "Faulted Not Found" status for NIC team after you restart Windows from an iSCSI boot disk

This article provides a resolution for the issue that it shows "Faulted Not Found" status for NIC team after you restart Windows from an iSCSI boot disk.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2969300

## Symptoms

Consider the following scenario:
- Windows Server 2012 or Windows Server 2012 R2 is configured to start from an iSCSI boot disk.
- An NIC team is configured to use a network adapter or adapters that are not involved in the iSCSI boot process.  

When the NIC team is first created, it works as expected. However, after you restart the server, the NIC team displays a "Faulted Not Found" status in Server Manager, and then it no longer works. If you try to remove the NIC team, the attempt is unsuccessful. 

## Cause

NIC Teaming is not supported when Windows Server 2012 or Windows Server 2012 R2 is started from an iSCSI boot disk. 

## Resolution

If you try to remove the NIC team through the Server Manager interface or by using the remove-netlbfoteam  PowerShell command, the process stops responding and cannot be completed. However, you must still perform this operation in order to remove the reference to the team. After you do this and then restart the server, the NIC team is no longer displayed. However, any attempt to use the old team name fails.
