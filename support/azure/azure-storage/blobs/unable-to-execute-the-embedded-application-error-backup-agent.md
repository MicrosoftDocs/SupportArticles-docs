---
title: Unable to execute the embedded application error when install Microsoft Azure backup agent
description: Describes how to fix the "Unable to execute the embedded application" error that occurs when you install Microsoft Azure backup agent.
author: genlin
ms.author: genli
ms.service: azure-storage
ms.subservice: storage-common-concepts
ms.date: 08/14/2020
ms.reviewer: shamv
---
# "Unable to execute the embedded application" error when you try to install the Microsoft Azure backup agent

_Original product version:_ &nbsp; Azure Backup, Windows Server 2008 R2 Datacenter, Windows Server 2008 R2 Enterprise, Windows Server 2008 R2 Foundation, Windows Server 2008 R2 Standard  
_Original KB number:_ &nbsp; 2934202

## Symptoms

When you try to install the Microsoft Azure backup agent on a server that's running Windows Server 2008 R2, the attempt fails. Additionally, you receive the following error message:

Unable to execute the embedded application to complete the installation.

> [!NOTE]
> This problem is known to occur with a virtual machine (VM) from a Windows Server 2008 R2 Datacenter SP1 image that was created from the image gallery. However, this same VM works as expected on Windows Server 2012.

## Cause

This problem occurs because of an issue with Microsoft .VC90.CRT. To fix the problem, you must install the previous version of the Visual C++ runtime.

When this problem occurs, the following is logged in the Application log, and this indicates that Microsoft.VC90.CRT is the problem:

```output
Log Name: Application
Source: SideBySide
Date: **date** **time**  
Event ID: 33
Task Category: None
Level: Error
Keywords: Classic
User: N/A
Computer: **computer_name**  
Description:
Activation context generation failed for "F:\e703768b6b4e0b79707d1228d22c236d\CBPSetup.exe". Dependent Assembly Microsoft.VC90.CRT,processorArchitecture="amd64",publicKeyToken="1fc8b3b9a1e18e3b",type="win32",version="9.0.21022.8" could not be found. Please use sxstrace.exe for detailed diagnosis.
You may also receive the following error message:

ERROR: Cannot resolve reference Microsoft.VC90.CRT,processorArchitecture="amd64",publicKeyToken="1fc8b3b9a1e18e3b",type="win32",version="9.0.21022.8".
ERROR: Activation Context generation failed.
```

## Resolution

To resolve this problem, you must install the Microsoft Visual C++ 2008 Redistributable Package (x64). Installing the latest version of the Visual C++ runtime does not fix this problem.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
