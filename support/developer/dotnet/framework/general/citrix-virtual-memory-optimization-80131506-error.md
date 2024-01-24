---
title: Citrix Memory Optimization causes 80131506 error
description: In a small number of cases, having .NET Framework applications running along with the Citrix Virtual Memory Optimization Service can lead to memory corruption in the managed process.
ms.date: 05/06/2020
ms.reviewer: shorne, scotbren
---
# Citrix Virtual Memory Optimization Service can lead to .NET application corruption

This article helps you resolve the problem where having .NET Framework applications running along with the Citrix Virtual Memory Optimization Service can lead to memory corruption in the managed process.

_Original product version:_ &nbsp; .NET Framework 3.5 Service Pack 1  
_Original KB number:_ &nbsp; 2480607

## Symptoms

Various application errors, including access violations or failure to load assemblies, can occur in your process that loads managed code. In the System Event log you will see as following error message with the error number 80131506:

> Fatal Execution Engine Exception.

## Cause

In rare cases, it is possible for the Citrix Virtual Memory Optimization Service to interact with managed processes and cause process corruption. It leads to the **Fatal Execution Engine** error and the process is terminated.

## Resolution

Disabling the Virtual Memory Optimization Service resolves the error.

> [!NOTE]
> Re-running the Native Image Generator (NGen.exe) on the affected machines resolves the issue as well. Run `NGen update /force` from a .NET framework or Visual Studio command prompt to update all native images.

```console
NGen update /force
```

Other customers have reported that Citrix can assist with setting exclusion policies for the service to avoid the problem-managed process.
