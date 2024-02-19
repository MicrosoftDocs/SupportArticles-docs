---
title: Fail to use PXE to boot clients from WDS
description: Provides a solution to fix an error that occurs when you use PXE to boot a client computer from a Windows Deployment Services (WDS) server.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, scottmca
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
---
# Invalid Boot File Received Error Message When PXE booting from WDS

This article provides help to fix an error that occurs when you use PXE to boot a client computer from a Windows Deployment Services (WDS) server.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2602043

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

For more information about he WDS Boot Program's for UEFI computers wdsmgfw.efi, see [Managing Network Boot Programs](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732351%28v=ws.10%29).
