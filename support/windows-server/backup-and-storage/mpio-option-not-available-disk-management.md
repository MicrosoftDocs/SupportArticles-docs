---
title: MPIO option not available in Disk Management in Windows Server 2019
description: Describes a change in Windows Server 2019, in which MPIO option is no longer available in Disk Management.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:multipath-i/o-mpio-and-storport, csstroubleshoot
ms.technology: windows-server-backup-and-storage
---
# MPIO option not in Disk Management in Windows Server 2019

This article describes a change in Windows Server 2019, in which MPIO option is no longer available in Disk Management.

_Applies to:_ &nbsp; Windows Server 2019  
_Original KB number:_ &nbsp; 4477064

## Symptom  

After you install the Multipath I/O (MPIO) feature on a server that's running Windows Server 2019 build 17763, you notice that the MPIO option is not available under **Disk Management** > **Microsoft Storage Space Device Properties** as it was in earlier versions of Windows.

## Workaround

To work around this issue, use a PowerShell cmdlet to configure MPIO. For example:

- Run [Get-MSDSMGlobalDefaultLoadBalancePolicy](/powershell/module/mpio/Get-MSDSMGlobalDefaultLoadBalancePolicy) in PowerShell to retrieve the MPIO policy.
- Run [Set-MSDSMGlobalDefaultLoadBalancePolicy -Policy RR](/powershell/module/mpio/Set-MSDSMGlobalDefaultLoadBalancePolicy) to set up the MPIO policy as round robin.

## Reference

For more information, see [MPIO](/powershell/module/mpio).
