---
title: Cannot create SSL/TLS secure channel when for Project Online OData from SSIS
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.service: o365-solutions
description: OData Connection to Project Online from SSIS is failing if TLS is not enabled.
appliesto:
- Project Online
---

# You can't connect to Project Online OData from SSIS

## Symptoms

When you try to connect to your Project Online OData feeds from SQL Server Integration Services (SSIS), you receive the following error message:

**Test connection failed**
**Additional Information**
**The request was aborted: Could not create SSL/TLS secure channel.**
**(Microsoft.SqlServer.IntegrationServices.ODataConnectionManager)**

## Cause

This issue occurs if Transport Layer Security (TLS) is not enabled.

## Resolution

> [!WARNING]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the Microsoft Help article:
[322756](https://support.microsoft.com/help/322756/how-to-back-up-and-restore-the-registry-in-windows) How to back up and restore the registry in Windows

To resolve this issue, add the **SchUseStrongCrypto** registry entry. To do this, run the appropriate command at a Command Prompt window, depending on your system type (64-bit or 32-bit):

```powershell
reg add HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319 /v SchUseStrongCrypto /t REG_DWORD /d 1 /reg:64
```

```powershell
reg add HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319 /v SchUseStrongCrypto /t REG_DWORD /d 1 /reg:32
```

## More Information

For more information about TLS, see [Transport Layer Security (TLS) best practices with the .NET Framework](https://docs.microsoft.com/dotnet/framework/network-programming/tls).
