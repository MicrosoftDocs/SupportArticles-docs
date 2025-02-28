---
title: LACP Timer is configured incorrectly when you create a new NIC Team for LBFO in Windows Server 2016
description: Describes an issue that misconfigures the LACP Timer when you create a new NIC Team for LBFO in Windows Server 2016. A workaround is provided.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, arudell, christys
ms.custom:
- sap:network connectivity and file sharing\windows nic teaming (load balance failover)
- pcy:WinComm Networking
---
# LACP Timer is configured incorrectly when you create a new NIC Team for LBFO in Windows Server 2016

This article describes an issue that Link Aggregation Control Protocol (LACP) Timer is configured incorrectly when you create a new NIC Team for LBFO in Windows Server 2016.

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4014014

## Symptoms

In Windows Server 2016, there's a new feature that lets administrators configure the LACP Timer in either a **Fast** or **Slow** mode, depending on the device.
  
When you create a NIC Team for Load Balancing and Failover (LBFO) on Windows Server 2016 by using the `New-NetLbfoTeam` cmdlet, and you define the LACP Timer as **Fast**, the LBFO team that's created is configured with a **Slow** LACP Timer instead.  

## Workaround

To work around this issue, use the `Set-NetLbfoTeam` cmdlet to make the LBFO team use the correct LACP Timer.  

For example:

```powershell  
Set-NetLbfoTeam -LacpTimer Slow
```

## Reference

For more information about how to use `New-NetLbfoTeam` cmdlet, see [New-NetLbfoTeam](/powershell/module/netlbfo/new-netlbfoteam).

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
