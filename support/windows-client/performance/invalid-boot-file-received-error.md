---
title: Fail to use PXE to boot clients from WDS
description: Provides a solution to fix an error that occurs when you use PXE to boot a client computer from a Windows Deployment Services (WDS) server.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, scottmca
ms.prod-support-area-path: No Boot (not BugChecks)
ms.technology: windows-client-performance
---
# Invalid Boot File Received Error Message When PXE booting from WDS

This article provides help to fix an error that occurs when you use PXE to boot a client computer from a Windows Deployment Services (WDS) server.

_Original product version:_ &nbsp;Windows 10 - all editions  
_Original KB number:_ &nbsp;2602043

## Symptoms

When using PXE to boot a client computer from a WDS server, you may encounter one of the following symptoms or error messages

- Invalid boot file received
- PXE client hangs. At the point of the error you are executing code from the PXE bios, so the actual error message can vary.

## Cause

This can occur with the following scenario:

- You are using DHCP scope option 67 to direct PXE clients to download specific Boot Program using BootFileName.

- You have a mix of BIOS-based machines and UEFI machines and you attempt to boot the incorrect type of Boot Program

## Resolution

If you have a mix of UEFI and Legacy BIOS machines, you cannot use DHCP Scope Options to direct PXE clients to the Boot Program on the WDS server. You must use IP Helper Table Entries. For more information on configuring IP helper table entries, contact your router/switch manufacturer.

## More information

The WDS Boot Program's for each type of machine are:  

- Legacy BIOS computers: [Wdsnbp Website](http://wdsnbp.com/)
- UEFI computers: wdsmgfw.efi
 [Managing Network Boot Programs](https://technet.microsoft.com/library/cc732351%28ws.10%29.aspx)
