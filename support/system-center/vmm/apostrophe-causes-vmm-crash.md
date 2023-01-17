---
title: VMM console crashes with apostrophe characters
description: Fixes an issue in which a Virtual Machine Manager console crashes when you add a custom property that contains an apostrophe character to the virtual machine.
ms.date: 04/26/2020
ms.reviewer: markstan, jeffpatt
---
# Adding a custom property with an apostrophe in SCVMM 2012 causes the VMM console to crash

This article helps you fix an issue in which a Virtual Machine Manager console crashes when you add a custom property that contains an apostrophe character to the virtual machine.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2690553

## Symptoms

Adding a custom property that contains an apostrophe character (e.g. fabrikam's custom property) to a virtual machine (VM) in System Center 2012 Virtual Machine Manager (VMM) causes the Virtual Machine Manager console to crash with a signature similar to the following:

> **Description:**
>
> Stopped working  
>
> Problem signature:  
>
> Problem Event Name: CLR20r3  
> Problem Signature 01: vmmadminui.exe  
> Problem Signature 02: 1.0.523.0  
> Problem Signature 03: 4ed928ef  
> Problem Signature 04: mscorlib  
> Problem Signature 05: 2.0.0.0  
> Problem Signature 06: 4e1539fa  
> Problem Signature 07: 20c8  
> Problem Signature 08: 100  
> Problem Signature 09: N3CTRYE2KN3C34SGL4ZQYRBFTE4M13NB  
> OS Version: 6.1.7601.2.1.0.274.10  
> Locale ID: 1033  

A corresponding event will be written to the Application Log:  

> Log Name:      Application  
> Source:        Windows Error Reporting  
> Event ID:      1001  
> Task Category: None  
> Level:         Information  
> Keywords:      Classic  
> Description:  
> Fault bucket , type 0  
> Event Name: CLR20r3  
> Response: Not available  
> Cab Id: 0  
> Problem signature:  
> P1: vmmadminui.exe  
> P2: 1.0.523.0  
> P3: 4ed928ef  
> P4: mscorlib  
> P5: 2.0.0.0  
> P6: 4e1539fa  
> P7: 20c8  
> P8: 100  
> P9: N3CTRYE2KN3C34SGL4ZQYRBFTE4M13NB  
> P10:

## Cause

This is a known issue with System Center 2012 Virtual Machine Manager.

## Resolution

To resolve this issue, open the Virtual Machine Manager command shell and issue the following commands:

```powershell
Get-VMMServer -ComputerName localhost
```

```powershell
Get-SCCustomProperty  | Where-Object { $_.Name -match "'"} | Remove-SCCustomProperty
```

> [!NOTE]
> The `-match` condition is a single quote enclosed in a pair of double-quotes.

## More Information

If you cannot delete the custom property from PowerShell, you can modify the **Name** value in the `BTBS_CustomProperty` table of the VMM database.
