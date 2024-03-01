---
title: NTFRS deprecation blocks promotion of replica DCs
description: NTFRS deprecation intentionally blocks the promotion of Windows Server 2016 RS3 replica DCs.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# NTFRS deprecation intentionally blocks the installation of Windows Server version 1709 replica DCs

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4023141

## Symptom

When you use the [Install-ADDSDomainController](/powershell/module/addsdeployment/install-addsdomaincontroller) cmdlet to install a replica-domain controller that's running Windows Server version 1709 to a NTFRS-enabled domain, the installation fails, and you receive the following error message:

> The specified domain %1 is still using the File Replication Service (FRS) which is deprecated.  This server does not support FRS and cannot be promoted as a replica into the specified domain.  You should migrate the specified domain to use DFS Replication by using the DFSRMIG command before continuing.
>
> For more information, see https://go.microsoft.com/fwlink/?linkid=849270.
  
If the Windows Server version is earlier than Windows Server version 1709, you receive the following message:

> The File Replication Service (FRS) is deprecated. To continue replicating the SYSVOL folder, you should migrate to DFS Replication by using the DFSRMIG command.  If you continue to use FRS for SYSVOL replication in this domain, you might not be able to add domain controllers running a future version of Windows Server.

Servers that indirectly run the Install-ADDSDomainController cmdlet in Server Manager are also affected.  

## Cause

This behavior is intended and by design and consistent with previous announcements about the deprecation of NTFRS in future versions of Windows. Windows Server 2016 is the initial release that ends support of NTFRS.  

## Resolution

Use the steps in the following article to migrate sysvol replication from FRS to DFSR:

[Sysvol replication Migration Guide: FRS to DFS replication](https://technet.microsoft.com/library/dd640019%28WS.10%29.aspx)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
