---
title: Computer stops responding
description: Provides information about resolving a problem where computer stops responding when the Mscorsvw.exe process starts executing.
ms.date: 05/11/2020
ms.reviewer: gaurap
---
# Computer stops responding when the mscorsvw.exe process starts executing

This article helps you resolve the problem where your computer stops responding when the mscorsvw.exe process starts executing.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 2698881

## Symptoms

Your computer stops responding or performs slowly with high Central Processing Unit (CPU) because of mscorsvw.exe.

## Cause

Mscorsvw.exe performs CPU intensive operation while recompiling .NET assemblies in the background.

## Resolution

To work around this issue, skip this system process until the computer is idle.

Execute the following command from command prompt:

```console
ngen.exe executequeueditems
```

## More information

The mscorsvw.exe process runs in the background only when the following conditions are true:

- The highest-priority assemblies have to be compiled after this .NET Framework redistributable is installed.
- A .NET Framework application is installed to compile the .NET Framework assemblies.

> [!NOTE]
> The Mscorsvw.exe process usually pre-compiles high-priority assemblies within 5 to 10 minutes, and the mscorsvw.exe process tries to process the low-priority assemblies when the operating system is idle.
