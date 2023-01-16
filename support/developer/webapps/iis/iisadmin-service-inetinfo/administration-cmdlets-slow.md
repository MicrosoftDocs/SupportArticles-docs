---
title: IIS admin cmdlets slow in PowerShell 4.0
description: This article provides resolutions for the problem where IIS administration cmdlets running slowly in PowerShell 4.0.
ms.date: 04/07/2020
ms.custom: sap:IISAdmin service and Inetinfo process operation
ms.technology: iis-iisadmin-service-inetinfo
---
# Some IIS administration cmdlets run slowly in PowerShell 4.0

This article helps you resolve the problem where Microsoft Internet Information Services (IIS) administration cmdlets running slowly in PowerShell 4.0.

_Original product version:_ &nbsp; Internet Information Services, Windows Server 2008 R2, Windows PowerShell 4.0  
_Original KB number:_ &nbsp; 3144309

## Symptoms

Consider the following scenario:

- You're using the IIS web administration module to create and manage IIS web applications with PowerShell scripts.
- You're running Windows Server 2008 R2.
- You're using `New-WebApplication` or `ConvertTo-WebApplication` cmdlets.

In this scenario, your scripts run much slower in PowerShell 4.0 than in PowerShell 2.0. This issue doesn't occur if you run the same scripts in Windows Server 2012 or later.

## Cause

This issue occurs because the `New-WebApplication` and `ConvertTo-WebApplication` cmdlets generate a high volume of Component Object Model (COM) calls. By default, PowerShell 4.0 runs in the STA threading model and PowerShell 2.0 runs in the MTA threading model.

## Resolution

If possible, migrate to Windows Server 2012 or later. Some cmdlets run much faster in PowerShell 4.0 in a Windows Server 2012 environment or later.

To improve speed, run PowerShell using the `-mta` switch:

```powershell
Powershell.exe -mta
```

Alternatively, run PowerShell using the `-version 2` switch:

```powershell
Powershell.exe -version 2
```
