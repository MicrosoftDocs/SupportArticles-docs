---
title: Enable event-based refresher mode for VMM hosts
description: Describes a new, event-based triggering system for host refresh in Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# How to enable the event-based refresher mode for Virtual Machine Manager hosts

This article describes a new, event-based triggering system for host refresh in Virtual Machine Manager.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager, Microsoft System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 3001854

## Summary

Microsoft System Center 2012 Virtual Machine Manager Service Pack 1 (SP1) and later versions of Virtual Machine Manager enable a new, event-based triggering system for host refresh. This system replaces previous, push-based modes that were based on intervals that were specified in the registry. Generally, we recommend this new mode because it improves consistency and makes sure that there is less change data about which the Virtual Machine Manager server must be notified.

## Update host computers

In some cases, the refresher mode may not be automatically set on Virtual Machine Manager hosts. To update host computers, run the following Windows PowerShell commands:

### Get a list of refresher mode settings for each host

```powershell
Get-SCVMHost | Sort-Object -Property Name | select @{Name="HostName";Expression={$_.Name}},@{Name="RefresherMode";Expression={$_.GetRefresherMode()}}
```

### This mode will be either Legacy or EventBased

```powershell
Get-SCVMHost | Where-Object -FilterScript {$_.GetRefresherMode() -eq "Legacy"} | ForEach-Object -Process { Read-SCVirtualMachine -VMHost $_ }
```

## Add a registry key

Be aware that, after you install System Center 2012 R2 Update Rollup 6 (SC 2012 R2 UR6), you must make an additional change in order to enable the correct refreshing of virtual machines across hosts. If you are using System Center 2012 R2 Update Rollup 6 or a later version, you must add the following registry values on the Virtual Machine Manager server:

Registry location: `HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft System Center Virtual Machine Manager Server\Settings`  
Registry key: `VMPropertiesEventAssitedUpdateInterval`  
Registry type: **DWORD**  
Min value: **0 seconds**  
Max value: **20 days**

> [!NOTE]
> The values for `VMPropertiesEventAssitedUpdateInterval` must be specified in seconds.

You can add this registry key manually or use the following sample PowerShell script:

```powershell
New-ItemProperty 'HKLM:\software\microsoft\Microsoft System Center Virtual Machine Manager Server\Settings' -Name VMPropertiesEventAssitedUpdateInterval -Value 120 -PropertyType "DWord" -Force
```

You can also change the light refresher interval by editing the `VMPropertiesUpdateInterval` registry value. The default interval is 2 minutes (120 seconds).

For more information, see the following Microsoft Knowledge Base article:

[3050317](https://support.microsoft.com/help/3050317) Update Rollup 6 for System Center 2012 R2 Virtual Machine Manager
