---
title: LoadLibrary function returns STATUS_DLL_NOT_FOUND error on impersonate thread in Windows
description: Describes an issue that causes the LoadLibrary function to return a STATUS_DLL_NOT_FOUND error on an impersonate thread in Windows 10 and Windows Server 2016.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, hirotoh
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# LoadLibrary function returns STATUS_DLL_NOT_FOUND error on impersonate thread in Windows

This article provides a workaround for an issue where LoadLibrary function returns STATUS_DLL_NOT_FOUND error on impersonate thread in Windows.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows 10 - all editions  
_Original KB number:_ &nbsp; 4015510

## Symptoms

In Windows 10 and Windows Server version 1709 or later versions, if you do not grant dynamic-link library (DLL) access to the process token itself when you use the **LoadLibrary** function to load the DLL, you receive a "STATUS_DLL_NOT_FOUND" error message on impersonate threads.

## Cause

> [!Note]
> This behavior is by design in Windows.

This behavior occurs for the following reasons:

- It's assumed that all Windows-based operating systems have access rights to the DLL that's referred to by the process token.
- Regardless of the condition that's described in the preceding bullet point, this problem is more obvious in Windows 10, Windows Server 2016, Windows Server 2019, and Windows Server, version 1909 than in earlier versions of Windows.

## Workaround

To work around this issue, make sure that process tokens have access rights to all the executables that the process loads.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
