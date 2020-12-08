---
title: MPIO option not available in Disk Management in Windows Server 2019
description: Describes a change in Windows Server 2019, in which MPIO option is no longer available in Disk Management.
ms.date: 12/04/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# MPIO option not in Disk Management in Windows Server 2019

_Original product version:_ &nbsp; Windows Server 2019 Datacenter, Windows Server 2019 Standard  
_Original KB number:_ &nbsp; 4477064

## Symptom  

After you install the Multipath I/O (MPIO) feature on a server that's running Windows Server 2019 build 17763, you notice that the MPIO option is not available under **Disk Management** -> **Microsoft Storage Space Device Properties** as it was in earlier versions of Windows. 

## Workaround

To work around this issue, use a PowerShell cmdlet to configure MPIO. For example: 
- Run [Get-MSDSMGlobalDefaultLoadBalancePolicy](https://docs.microsoft.com/powershell/module/mpio/Get-MSDSMGlobalDefaultLoadBalancePolicy?view=win10-ps)  in PowerShell to retrieve the MPIO policy. 
- Run [Set-MSDSMGlobalDefaultLoadBalancePolicy -Policy RR](https://docs.microsoft.com/powershell/module/mpio/Set-MSDSMGlobalDefaultLoadBalancePolicy?view=win10-ps)  to set up the MPIO policy as round robin. 

## Reference

For more information, see [MPIO](https://docs.microsoft.com/powershell/module/mpio/?view=win10-ps).
