---
title: Active Directory changes don't replicate
description: Provides a solution to an issue where the replication isn't completed when you replicate Active Directory directory service changes to a domain controller.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, rolandw
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Active Directory changes do not replicate

This article provides a solution to an issue where the replication isn't completed when you replicate Active Directory directory service changes to a domain controller.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 830746

## Symptoms

When you try to replicate Active Directory directory service changes to a Microsoft Windows Server 2003-based domain controller, the replication is not completed.

In the event log, you may see events that are similar to the following: In this situation, you also see error 1818 in the output of the repadmin /showrepl command and in the output of the repadmin /showreps command.

## Cause

This issue may occur when destination domain controllers that are performing remote procedure call (RPC)-based replication do not receive replication changes from a source domain controller within the time that the RPC Replication Timeout (mins) registry setting specifies. You might experience this issue most frequently in one of the following situations:

- You promote a new domain controller into the forest by using the Active Directory Installation Wizard (Dcpromo.exe).
- Existing domain controllers replicate from source domain controllers that are connected over slow network links.

The default value for the RPC Replication Timeout (mins) registry setting on Windows 2000-based computers is 45 minutes. The default value for the RPC Replication Timeout (mins) registry setting on Windows Server 2003-based computers is 5 minutes. When you upgrade the operating system from Windows 2000 to Windows Server 2003, the value for the RPC Replication Timeout (mins) registry setting is changed from 45 minutes to 5 minutes. If a destination domain controller that is performing RPC-based replication does not receive the requested replication package within the time that the RPC Replication Timeout (mins) registry setting specifies, the destination domain controller ends the RPC connection with the non-responsive source domain controller and logs a Warning event.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To resolve this issue, increase the bandwidth of your network connection so that the Active Directory changes replicate in the five-minute timeout period. If you cannot increase the bandwidth of your network connection, edit the registry on your Windows Server 2003-based computer to increase the value of the RPC timeout for Active Directory replication. To increase the RPC timeout value, follow these steps:

1. Start Registry Editor.
2. Locate the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters` 
3. Right-click **Parameters**, point to **New**, and then click **DWORD Value**.
4. Type RPC Replication Timeout (mins), and then press ENTER to name the new value.
5. Right-click **RPC Replication Timeout (mins)**, and then click **Modify**.
6. In the **Value data** box, type the number of minutes that you want to use for the RPC timeout for Active Directory replication, and then click **OK**. On a Windows Server 2003-based computer that is part of a Windows 2000 environment or that was upgraded from Windows 2000 Server, you may want to set this value to 45 minutes.

> [!NOTE]
> You must restart the computer to activate any changes that are made to **RPC Replication Timeout (mins)**.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
